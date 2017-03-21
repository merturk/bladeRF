/*
 * This file is part of the bladeRF project:
 *   http://www.github.com/nuand/bladeRF
 *
 * Copyright (C) 2017 Nuand LLC
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#ifndef BOARD_H__
#define BOARD_H__

#include <stdint.h>

#include <libbladeRF.h>

#include "host_config.h"
#include "thread.h"

#include "backend/backend.h"

struct bladerf {
    /* Handle lock - to ensure atomic access to control and configuration
     * operations */
    MUTEX lock;

    /* Identifying information */
    struct bladerf_devinfo ident;

    /* Backend-specific implementations */
    const struct backend_fns *backend;
    /* Backend's private data */
    void *backend_data;

    /* Board-specific implementations */
    const struct board_fns *board;
    /* Board's private data */
    void *board_data;

    /* XB attached */
    bladerf_xb xb;
    /* XB's private data */
    void *xb_data;
};

struct board_fns {
    /* Open/close */
    int (*open)(struct bladerf *dev, struct bladerf_devinfo *devinfo);
    void (*close)(struct bladerf *dev);

    /* Properties */
    bladerf_dev_speed (*device_speed)(struct bladerf *dev);
    int (*get_serial)(struct bladerf *dev, char *serial);
    int (*get_fpga_size)(struct bladerf *dev, bladerf_fpga_size *size);
    int (*is_fpga_configured)(struct bladerf *dev);
    uint64_t (*get_capabilities)(struct bladerf *dev);

    /* Versions */
    int (*get_fpga_version)(struct bladerf *dev, struct bladerf_version *version);
    int (*get_fw_version)(struct bladerf *dev, struct bladerf_version *version);

    /* Enable/disable */
    int (*enable_module)(struct bladerf *dev, bladerf_module m, bool enable);

    /* Gain */
    int (*set_gain)(struct bladerf *dev, bladerf_module mod, int gain);
    int (*set_gain_mode)(struct bladerf *dev, bladerf_module mod, bladerf_gain_mode mode);
    int (*get_gain_mode)(struct bladerf *dev, bladerf_module mod, bladerf_gain_mode *mode);

    /* Sample Rate */
    int (*set_sample_rate)(struct bladerf *dev, bladerf_module module, unsigned int rate, unsigned int *actual);
    int (*set_rational_sample_rate)(struct bladerf *dev, bladerf_module module, struct bladerf_rational_rate *rate, struct bladerf_rational_rate *actual);
    int (*get_sample_rate)(struct bladerf *dev, bladerf_module module, unsigned int *rate);
    int (*get_rational_sample_rate)(struct bladerf *dev, bladerf_module module, struct bladerf_rational_rate *rate);

    /* Bandwidth */
    int (*set_bandwidth)(struct bladerf *dev, bladerf_module module, unsigned int bandwidth, unsigned int *actual);
    int (*get_bandwidth)(struct bladerf *dev, bladerf_module module, unsigned int *bandwidth);

    /* Frequency */
    int (*get_frequency)(struct bladerf *dev, bladerf_module module, unsigned int *frequency);
    int (*set_frequency)(struct bladerf *dev, bladerf_module module, unsigned int frequency);
    int (*select_band)(struct bladerf *dev, bladerf_module module, unsigned int frequency);

    /* Scheduled Tuning */
    int (*get_quick_tune)(struct bladerf *dev, bladerf_module module, struct bladerf_quick_tune *quick_tune);
    int (*schedule_retune)(struct bladerf *dev, bladerf_module module, uint64_t timestamp, unsigned int frequency, struct bladerf_quick_tune *quick_tune);
    int (*cancel_scheduled_retunes)(struct bladerf *dev, bladerf_module m);

    /* Trigger */
    int (*trigger_init)(struct bladerf *dev, bladerf_module module, bladerf_trigger_signal signal, struct bladerf_trigger *trigger);
    int (*trigger_arm)(struct bladerf *dev, const struct bladerf_trigger *trigger, bool arm, uint64_t resv1, uint64_t resv2);
    int (*trigger_fire)(struct bladerf *dev, const struct bladerf_trigger *trigger);
    int (*trigger_state)(struct bladerf *dev, const struct bladerf_trigger *trigger, bool *is_armed, bool *has_fired, bool *fire_requested, uint64_t *resv1, uint64_t *resv2);

    /* Streaming */
    int (*init_stream)(struct bladerf_stream **stream, struct bladerf *dev, bladerf_stream_cb callback, void ***buffers, size_t num_buffers, bladerf_format format, size_t samples_per_buffer, size_t num_transfers, void *user_data);
    int (*stream)(struct bladerf_stream *stream, bladerf_module module);
    int (*submit_stream_buffer)(struct bladerf_stream *stream, void *buffer, unsigned int timeout_ms, bool nonblock);
    void (*deinit_stream)(struct bladerf_stream *stream);
    int (*set_stream_timeout)(struct bladerf *dev, bladerf_module module, unsigned int timeout);
    int (*get_stream_timeout)(struct bladerf *dev, bladerf_module module, unsigned int *timeout);
    int (*sync_config)(struct bladerf *dev, bladerf_module module, bladerf_format format, unsigned int num_buffers, unsigned int buffer_size, unsigned int num_transfers, unsigned int stream_timeout);
    int (*sync_tx)(struct bladerf *dev, void *samples, unsigned int num_samples, struct bladerf_metadata *metadata, unsigned int timeout_ms);
    int (*sync_rx)(struct bladerf *dev, void *samples, unsigned int num_samples, struct bladerf_metadata *metadata, unsigned int timeout_ms);
    int (*get_timestamp)(struct bladerf *dev, bladerf_module mod, uint64_t *value);

    /* SMB Clock Configuration (board-agnostic feature?) */
    int (*get_smb_mode)(struct bladerf *dev, bladerf_smb_mode *mode);
    int (*set_smb_mode)(struct bladerf *dev, bladerf_smb_mode mode);
    int (*get_smb_frequency)(struct bladerf *dev, unsigned int *rate);
    int (*set_smb_frequency)(struct bladerf *dev, uint32_t rate, uint32_t *actual);
    int (*get_rational_smb_frequency)(struct bladerf *dev, struct bladerf_rational_rate *rate);
    int (*set_rational_smb_frequency)(struct bladerf *dev, struct bladerf_rational_rate *rate, struct bladerf_rational_rate *actual);

    /* DC/Phase/Gain Correction */
    int (*get_correction)(struct bladerf *dev, bladerf_module module, bladerf_correction corr, int16_t *value);
    int (*set_correction)(struct bladerf *dev, bladerf_module module, bladerf_correction corr, int16_t value);

    /* FPGA/Firmware Loading/Flashing */
    int (*load_fpga)(struct bladerf *dev, const uint8_t *buf, size_t length);
    int (*flash_fpga)(struct bladerf *dev, const uint8_t *buf, size_t length);
    int (*erase_stored_fpga)(struct bladerf *dev);
    int (*flash_firmware)(struct bladerf *dev, const uint8_t *buf, size_t length);
    int (*device_reset)(struct bladerf *dev);

    /* Sample Internal/Direct */
    int (*get_sampling)(struct bladerf *dev, bladerf_sampling *sampling);
    int (*set_sampling)(struct bladerf *dev, bladerf_sampling sampling);

    /* Sample RX FPGA Mux */
    int (*get_rx_mux)(struct bladerf *dev, bladerf_rx_mux *mode);
    int (*set_rx_mux)(struct bladerf *dev, bladerf_rx_mux mode);

    /* Tune on host or FPGA */
    int (*set_tuning_mode)(struct bladerf *dev, bladerf_tuning_mode mode);

    /* Expansion support */
    int (*expansion_attach)(struct bladerf *dev, bladerf_xb xb);
    int (*expansion_get_attached)(struct bladerf *dev, bladerf_xb *xb);
};

/* Boards */
extern const struct board_fns bladerf1_board_fns;
extern const struct board_fns bladerf2_board_fns;

#endif
################################################################################
#
# fpga-manager
#
################################################################################

LINUX_EXTENSIONS += fpga-manager

define FPGA_MANAGER_PREPARE_KERNEL
	`# Remove the existing driver is it exists`; \
	if [ -e $(LINUX_DIR)/drivers/fpga ]; then \
		rm -r $(LINUX_DIR)/drivers/fpga; \
		sed -i "s:source \"drivers/fpga/Kconfig\"::g" $(LINUX_DIR)/drivers/Kconfig; \
		sed -i "s:obj-\$$(CONFIG_FPGA)\t\t+= fpga/::g" $(LINUX_DIR)/drivers/Makefile; \
	fi; \
	\
	`# Create destination directory`; \
	DEST_DIR=$(LINUX_DIR)/drivers/wrtd_ref_spec150t_adc; \
	mkdir -p $${DEST_DIR}; \
	if [ ! -e $${DEST_DIR}/Kconfig ]; then \
		echo "source \"drivers/wrtd_ref_spec150t_adc/Kconfig\"" >> $(LINUX_DIR)/drivers/Kconfig; \
	fi; \
	\
	`# Copy headers`; \
	cp -dpfr $(FPGA_MANAGER_DIR)/include/* $(LINUX_DIR)/include; \
	\
	`# Copy sources`; \
	cp -dpfr $(FPGA_MANAGER_DIR)/drivers/fpga $${DEST_DIR}; \
	\
	echo "source drivers/wrtd_ref_spec150t_adc/fpga/Kconfig" >> $${DEST_DIR}/Kconfig; \
	\
	`# Edit Makefile`; \
	echo "obj-m += fpga/" >> $${DEST_DIR}/Makefile;
endef

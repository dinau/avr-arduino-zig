ARDUINO_VER = 1.8.16
COM_PORT = COM3
AVRDUDE_BAUDRATE = 115200
#COM_PORT = COM5
#AVRDUDE_BAUDRATE = 57600
AVR_GCC_DIR = D:/arduino-$(ARDUINO_VER)/hardware/tools/avr
CONF = $(AVR_GCC_DIR)/etc/avrdude.conf

TARGET = avr-arduino-zig

all:
	zig build
	@size zig-out/bin/$(TARGET)
	@zig build objdump > $(TARGET).lst

.PHONY: clean

clean:
	rm -fr zig-out zig-cache

w: all
	$(AVR_GCC_DIR)/bin/avrdude -C $(CONF) -c arduino -P $(COM_PORT) -p m328p -b $(AVRDUDE_BAUDRATE)   -u -e -U flash:w:"zig-out/bin/$(TARGET)":a


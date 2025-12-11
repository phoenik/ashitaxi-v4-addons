addon.name = 'humbug';
addon.author = 'phoenik';
addon.version = '1.00';
addon.desc = 'Blocks starlight celebration music.';
addon.link = 'https://ashitaxi.com/';

require('common');

ashita.events.register('packet_in', 'packet_in_cb', function (e)
    -- Packet: Zone In
    if (e.id == 0x0A) then
        local song1 = struct.unpack('H', e.data, 87); -- Daytime Music
        local song2 = struct.unpack('H', e.data, 89); -- Nighttime Music

        if (song1 == 0xEF) then
            ashita.bits.pack_be(e.data_modified_raw, 110, 86, 0, 16);
        end

        if (song2 == 0xEF) then
            ashita.bits.pack_be(e.data_modified_raw, 110, 88, 0, 16);
        end
    end

    if (e.id == 0x5F) then
        local song = struct.unpack('H', e.data, 7); -- Incoming Song

        if (song == 0xEF) then
            e.blocked = true;
        end
    end
end);

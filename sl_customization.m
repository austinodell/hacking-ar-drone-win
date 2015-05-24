function sl_customization( cm )
    disp('Adding tcpip external mode to test target');
    cm.ExtModeTransports.add('ard.tlc', 'tcpip','ext_comm', 'Level1');
end
function transfer( file )

ftp_obj = ftp('192.168.1.1');
mput(ftp_obj,file);
close(ftp_obj);

end


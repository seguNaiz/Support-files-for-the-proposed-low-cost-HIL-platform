% % Attach to the target computer file system.
f=SimulinkRealTime.fileSystem;
% 
% % Open the file, read the data, close the file.

figure;
n=5;%File quantity
for i=1:n
    name = "chatRtFeed_tool" + "_t" + string(i);
    datFileName = name + ".dat";
    matFileName = name + ".mat";
    name = char(name);
    matFileName = char(matFileName);
    fileDir = "H:\" + datFileName;
    fileDir = char(fileDir);        
    
    h=fopen(f,fileDir');
    data=fread(f,h);
    f.fclose(h);
    
    data = uint8(data');
    new_data=readxpcfile(data);
    
    if (exist(matFileName) == 0)
       save(name,'new_data'); 
    end
    
    plot(new_data.data(:,3),new_data.data(:,1)); 
    hold on;
end


% figure;
% for i=1:n
%     name = "chat" + "_t" + string(i);
%     datFileName = name + ".dat";
%     matFileName = name + ".mat";
%     name = char(name);
%     matFileName = char(matFileName);
%     fileDir = "H:\" + datFileName;
%     fileDir = char(fileDir);        
%     
%     h=fopen(f,fileDir');
%     data=fread(f,h);
%     f.fclose(h);
%     
%     data = uint8(data');
%     new_data=readxpcfile(data);
%     
%     plot(new_data.data(:,3),new_data.data(:,2)); 
%     hold on;
% end



% figure;
% n=1;%File quantity
% for i=1:n
%     name = "chat";
%     matName = name + "_t" + string(i) + ".mat";
%     matName = char(matName);
%     load(matName);
% 
%     plot(new_data.data(:,3),new_data.data(:,1)); 
%     hold on;
% end



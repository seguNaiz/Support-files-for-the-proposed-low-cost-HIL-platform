%%%%
figure;
f_i = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

i_init = 1;
i_end = 5;
for i=i_init:i_end
    %name = 'shaker_gen'; %change only this
    name = "shaker" + "_t" + string(i);
    matName = name + ".mat";
    matName = char(matName);
    txtName = name + ".txt";
    txtName = char(txtName);
    name = char(name);

    if (exist(matName) == 0)
        data = importdata(txtName);
        save(name,'data');
    end
    load(matName);

    curveName = char("shakerData-test" + string(i));
    f(f_i) = plot(data,'DisplayName', curveName);
    f_i = f_i + 1;
    hold on;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

legend;%to insert the legend in the figure automatically
xlim([0 8000])




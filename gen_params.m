function p = gen_params(prev_data,fnames)

if isempty(prev_data)
[P] = xlsread('Parameters.xlsx');
params = {'S0','P0','phi','N','mup','mun','theta','P_eggs','P_breed','r0','S_eggs','S_breed','beta','rn'};
for i = 1:size(P,1)
    row = num2str(i);
    eval(['p.',params{i},' = unifrnd(P(',row,',1),P(',row,',2));'])
end
else
    for i = 1:length(fnames)
        cname = cellstr(fnames{i});
        cname = cname{1};
        index = randi(size(prev_data,1));
        std = mean(prev_data(:,i+1))/50;
        new_param = normrnd(prev_data(index,i+1),std);
        if new_param < 0
            while new_param < 0
                new_param = normrnd(prev_data(index,i+1),std);
            end
        end
        eval(['p.',cname,' = new_param;'])
    end
end

end
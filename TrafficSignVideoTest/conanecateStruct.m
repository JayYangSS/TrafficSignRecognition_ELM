function out = conanecateStruct(startIndex,endIndex,imgWidth,imgHeight)
%startIndex  --the start index in the sub directory of the training files
%endIndex    --the end index in the sub directory of the training files

d=[];
for index = startIndex:endIndex
    
    data=parseXML(index,imgWidth,imgHeight);
    if isempty(data)==0
        d = cat(3,d, struct2cell(data));
    end
end
out = cell2struct(d,fieldnames(data),1);
end


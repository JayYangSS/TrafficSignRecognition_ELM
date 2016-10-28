%% this function is save the detection and recognition result into the xml files(format of openCV)
function getXMLResult( variable, fileName, flag)

% Write mode as default
if ( ~exist('flag','var') )
    flag = 'w';
end

if ( ~exist(fileName,'file') || flag == 'w' )
    % New file or write mode specified
    file = fopen( fileName, 'w');
    fprintf( file, '<?xml version="1.0"?>\n');
    fprintf( file, '<opencv_storage>\n');
else
    % Append mode
    file = fopen( fileName, 'a');
end

frameNum=size(variable,1);
% Write variable header
fprintf( file, '<FrameNumber>%d</FrameNumber>\n',frameNum);
for frameIndex=0:frameNum-1
    targetNum=variable(frameIndex+1).targetNum; %target num in this frame
    fprintf(file,'<Frame%05dTargetNumber>%d</Frame%05dTargetNumber>\n',frameIndex,targetNum,frameIndex);
    %deteails of the  target
    for targetId=0:targetNum-1
        targetBox=variable(frameIndex+1).targetResult{targetId+1,1};
        targetLabel=variable(frameIndex+1).targetResult{targetId+1,2};
        
        fprintf(file,'<Frame%05dTarget%05d>\n',frameIndex,targetId);
        fprintf(file,'  <Type>"%s"</Type>\n',targetLabel);
        fprintf(file,'  <Position>\n');
        fprintf(file,'    %d %d %d %d</Position></Frame%05dTarget%05d>\n',targetBox(1),targetBox(2),targetBox(3),targetBox(4),frameIndex,targetId);
    end
end
fprintf( file, '</opencv_storage>\n');
fclose(file);
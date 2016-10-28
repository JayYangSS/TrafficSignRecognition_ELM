%判断标识类别是否为信号灯
function result=isLightType(type)
TLType={'"圆形红灯"','"圆形绿灯"','"圆形黄灯"','"右转箭头红灯"','"右转箭头绿灯"','"右转箭头黄灯"','"直行箭头红灯"','"直行箭头绿灯"','"直行箭头黄灯"','"左转箭头红灯"','"左转箭头绿灯"','"左转箭头黄灯"'};
result=0;

for i=1:12
    if strcmp(type,TLType(i))==1
        result=1;
        return;
    end
end
end
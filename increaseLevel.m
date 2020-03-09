function  increaseLevel()
level = evalin('base','level');
level=level+1;
assignin('base','level',level);
if(level==10)
    f = msgbox('you lose');
end
return
end


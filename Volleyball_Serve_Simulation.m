clear all
contactHeight=8*12+6;
pcX0 = 12*32:12*32+3;
pcY0 = 12*20-contactHeight:12*20-contactHeight+3;
pcX = 12*32:12*32+3;
pcY = 12*20-contactHeight:12*20-contactHeight+3;
for n = 1 : 6
    vB(n).x0 = (pcX0);
    vB(n).y0 = (pcY0);
    vB(n).x = (pcX);
    vB(n).y = (pcY);
    vB(n).spd = (45)/0.0568181818;
    vB(n).ang = -4+(-4*n);
end
vBColors = ...
[.6 0 0]; % red
white = [1 1 1];
for i = 1:28
vBColors = [vBColors;white];
end
gradient = [.5 .5 1];
for i = 1:10
vBColors = [vBColors;gradient*(i/20+.4)];
end
gradient = [1 .5 .5];
for i = 1:10
vBColors = [vBColors;gradient*(i/20+.4)];
end
gradient = [.5 1 .5];
for i = 1:10
vBColors = [vBColors;gradient*(i/20+.4)];
end

m=ones(20*12,59*12)*10; %background
for i = 1:50
	m(2,i) = i;
end
m(20*12,1:59*12)=0; %court
m((20*12)-(7*12+4):(20*12)-(4*12+4),6+29*12)=0; %net
%m(12*20-1,1:12*18)=7; %backcourt
m((18*12)-6*12:18*12,12*32:12*32+2)=0; %player
m(vB(1).y0,vB(1).x0)=20; %ball
colormap(vBColors);
caxis([0,3]);
imagesc(m)
colorbar
truesize();
vB(1).y;
time=0;
pps = .009;
speed = 2280;%2280in/s=130mph/h
s1 = 40/0.0568181818;
pcG = 1/2*32.1740*12;
pause(.9);
while(vB(1).y(:)<12*20)%ideal projectile, neglects air resistance and wind speed, spin of the projectile, and other effects influencing the flight
    time = time+.009;
    imagesc(m)
    for n =1:6
        vB(n).y=vB(n).y0(:)-(sind(vB(n).ang)*vB(n).spd*time-(pcG*time^2));
        
        
        temp=find(vB(n).y(:)>=12*20);
        if size(temp)>0
           vB(n).y(:)= 12*20;
        else
           vB(n).x=vB(n).x0(:)-(cosd(vB(n).ang)*vB(n).spd*time); 
        end
        m(round(vB(n).y),round(vB(n).x))=vB(n).spd*0.0568181818;
    end
    pause(.0001);
    %temp=find(m==5);
    %m(temp)=0;
    
end
colorbar
truesize();
text(600,45,strcat('Max Angle(deg): ',num2str(vB(6).ang)))
text(600,35,strcat('Min Angle(deg): ',num2str(vB(1).ang)))
text(600,25,strcat('Speed(mph): ',num2str(vB(1).spd*0.0568181818)))
text(600,15,strcat('Contact Height(feet): ',num2str(contactHeight/12)))
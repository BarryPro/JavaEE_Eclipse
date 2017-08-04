<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">    
<HTML>    
    <HEAD>    
        <TITLE>TrackBar </TITLE>    
        <META NAME="Generator" CONTENT="EditPlus">    
        <META NAME="Author" CONTENT="">    
        <META NAME="Keywords" CONTENT="">    
        <META NAME="Description" CONTENT="">    
        <script language="javascript">    
            var objContainsDiv;    
            var objTrackBar;    
            var objTrackPath;    
            var objScaleDiv;    
                
            var scaleNumber = 20;    
            var scaleLenth;//刻度长度    
                
            var vLeft;    
                
            var vaildLength;//滑块能够移动的有效长度(仅由容器对象的宽度和trackBar对象的宽度来决定)    
                
            function loadPage(){    
                    
                objContainsDiv = containsDiv;//容器    
                //debugger;    
                objTrackBar = createBar();    
                objTrackBar = objContainsDiv.appendChild(objTrackBar);    
                    
                objTrackPath = trackPath;//trackPath    
                    
                objTrackBar.onmousedown = trackBarBeforeMove;    
                objTrackBar.onmouseup = trackBarBeforeMouseup;    
                objTrackPath.onclick = setPosition;    
   
                vaildLength = parseInt(objContainsDiv.offsetWidth) - parseInt(objTrackBar.offsetWidth) - 2;    
                scaleLenth = Math.round(parseInt(objContainsDiv.offsetWidth)/scaleNumber);    
                    
                //画刻度线    
                for(var i=0;i<scaleNumber - 1;i++){    
                    objScaleDiv = this.document.createElement("<div style='position:absolute;left:50;top:13;font-size:4pt;font-weight:lighter;color:#999999;width:3:'/>");    
                    objScaleDiv = objContainsDiv.appendChild(objScaleDiv);    
                    with(objScaleDiv){    
                        style.left = scaleLenth*(i + 1);    
                        innerText = "|";    
                    }    
                }
				objTrackBar.style.left=345
            }    
                
            function createBar(){//创建滑块    
                
                var objBarContainsDiv;    
                objBarContainsDiv = this.document.createElement("<div style='position:absolute;left:0;top:0;height:16;width:11;z-index:2;'/>");    
                    
                //创建矩形区域    
                var objBarTop = this.document.createElement("<div style='position:absolute;left:0;top:0;height:10;width:11;font-size:1px;border-top:solid 1px #999999;border-right:solid 1px #666666;border-left:solid 1px #cccccc;z-index:2;background:#cccccc;'>");    
                objBarTop = objBarContainsDiv.appendChild(objBarTop);    
                    
                var objPointDiv;    
                var iScale = 0;    
   
                for(var i=0;i<6;i++){    
                    objPointDiv = this.document.createElement("<div style='position:absolute;background:red;font-size:1px;z-index:2;border-right:solid 1px #990000;'>");    
                    iScale = i + 1;    
                    with(objPointDiv){    
                        style.left = iScale;    
                        style.top = parseInt(objBarTop.style.pixelHeight) + (iScale - 1);    
                        if((parseInt(objBarTop.style.pixelWidth) - 2*iScale)<0){    
                            break;    
                        }    
                        style.width = parseInt(objBarTop.style.pixelWidth) - 2*iScale;    
                    }    
                    objPointDiv = objBarContainsDiv.appendChild(objPointDiv);    
                }    
                    
                return objBarContainsDiv;    
                    
            }    
                
            function setPosition(){//单击trackPath的时候将滑块移动到当前位置    
                    
                trackBarBeforeMoving();    
                //level.innerText = Math.round(parseInt(objTrackBar.style.left)*100/vaildLength) + "%";    
            gotoVolumn(Math.round(parseInt(objTrackBar.style.left)*100/vaildLength));
            }    
                
            function trackBarBeforeMove(){//滑块移动前    
                vLeft = window.event.x - objTrackBar.style.pixelLeft;    
                objTrackBar.style.background = "#dddddd";    
                objTrackBar.setCapture();    
                objTrackBar.attachEvent("onmousemove", trackBarBeforeMoving);    
            }    
                
            function trackBarBeforeMoving(){//滑块移动中    
                    
                var leftPoint;          
                var pointDividLength;    
                var vMousePositionX;    
                ///////////////////////////////////    
                if((event.x - objContainsDiv.offsetLeft - 8) > vaildLength || event.x<objContainsDiv.offsetLeft) return;    
                    
                ///////////////////////    
                    
                vMousePositionX = parseInt(event.x) - objContainsDiv.offsetLeft;    
                leftPoint = Math.floor(vMousePositionX/scaleLenth);//左边最近的点序号    
                pointDividLength = leftPoint*scaleLenth + scaleLenth/2;    
                if(vMousePositionX < pointDividLength){//粘连到左边点    
                    objTrackBar.style.left = leftPoint*scaleLenth;    
                    //return;    
                }    
                if(vMousePositionX > pointDividLength){//粘连到右边点    
                    objTrackBar.style.left = (leftPoint+1)*scaleLenth;    
                    //return;    
                }    
                    
                ///////////////////////////////////    
                
                if(parseInt(objTrackBar.style.left)>vaildLength){//移到了右边界    
                    objTrackBar.style.left = vaildLength;    
                }    
                    
                if(parseInt(objTrackBar.style.left)<0){//移到了左边界    
                    objTrackBar.style.left = 0;    
                }    
				
                    
               //level.innerText = Math.round(parseInt(objTrackBar.style.left)*100/vaildLength) + "%";    
            }    
                
            function trackBarBeforeMouseup(){//滑块结束解除绑定    
                if(parseInt(level.innerText.replace("%",""))>100){    
                    objTrackBar.style.left = vaildLength;    
                    //level.innerText = "100%";    
                }else if(parseInt(level.innerText.replace("%",""))<0){    
                    objTrackBar.style.left = 0;    
                    //level.innerText = "0%";    
                }  
                gotoVolumn(Math.round(parseInt(objTrackBar.style.left)*100/vaildLength));  
               
                objTrackBar.detachEvent("onmousemove", trackBarBeforeMoving);    
                objTrackBar.style.background = "#cccccc";    
                objTrackBar.releaseCapture();    
            }    
               
function gotoVolumn(value)
{
	 var adjustTime=0;
	 switch(value)
	 {
    case 0: 
     adjustTime=-10; 
     break;
    case 5: 
     adjustTime=-9; 
     break;
    case 10: 
     adjustTime=-8; 
     break;
    case 15: 
     adjustTime=-7; 
     break;
    case 20: 
     adjustTime=-6; 
     break;
    case 25: 
     adjustTime=-5; 
     break;
    case 31: 
     adjustTime=-4; 
     break;
    case 36: 
     adjustTime=-3; 
     break;
    case 41: 
     adjustTime=-2; 
     break;
    case 46: 
     adjustTime=-1; 
     break; 
    case 51: 
     adjustTime=0; 
     break;    
    case 56: 
     adjustTime=1; 
     break;       
    case 61: 
     adjustTime=2; 
     break;
    case 66: 
     adjustTime=3; 
     break;
    case 71: 
     adjustTime=4; 
     break;
    case 76: 
     adjustTime=5; 
     break;
    case 82: 
     adjustTime=6; 
     break;
    case 87: 
     adjustTime=7; 
     break;
    case 92: 
     adjustTime=8; 
     break;
    case 97: 
     adjustTime=9; 
     break;
    case 100: 
     adjustTime=10; 
     break;
	}
gohere(adjustTime);
}
        </script>   
         
    </HEAD>    
    <BODY onload="loadPage()">    
        <div id="containsDiv" style="position:absolute;left:10;top:50;border:solid 0px #cccccc;width:700;height:23;background:#dddddd;">    
            <hr id="trackPath" size="1" color="#cccccc" style="position:absolute;top:16;height:3;border:groove 1px #eeeeee;background:#666666;z-index:1;">    
        </div>    
        <span id="level" style="position:absolute;left:100;top:30;width:50;font-size:9pt;color:red;"></span>    
    </BODY>    
</HTML>

  <script language="javascript"> 
  	function gohere(value)
  	{
  	window.opener.cCcommonTool.AdjustVolume(value);
  	}
  </script>
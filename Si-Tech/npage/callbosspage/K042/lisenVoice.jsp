<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>  
<HTML>    
    <HEAD>    
        <TITLE>�������� </TITLE>    
        <META NAME="Generator" CONTENT="EditPlus">    
        <META NAME="Author" CONTENT="">    
        <META NAME="Keywords" CONTENT="">    
        <META NAME="Description" CONTENT="">    
        <script language="javascript">    
            var objContainsDiv;    
            var objTrackBar;    
            var objTrackPath;    
            var objScaleDiv;    
           //tancf     
            var scaleNumber = 10;    
            var scaleLenth;//�̶ȳ���    
                
            var vLeft;    
                
            var vaildLength;//�����ܹ��ƶ�����Ч����(������������Ŀ�Ⱥ�trackBar����Ŀ��������)    
                
            function loadPage(){    
                    
                objContainsDiv = containsDiv;//����    
                //debugger;    
                objTrackBar = createBar();    
                objTrackBar = objContainsDiv.appendChild(objTrackBar);    
                    
                objTrackPath = trackPath;//trackPath    
                    
                objTrackBar.onmousedown = trackBarBeforeMove;    
                objTrackBar.onmouseup = trackBarBeforeMouseup;    
                objTrackPath.onclick = setPosition;    
   
                vaildLength = parseInt(objContainsDiv.offsetWidth) - parseInt(objTrackBar.offsetWidth) - 2;    
                scaleLenth = Math.round(parseInt(objContainsDiv.offsetWidth)/scaleNumber);    
                    
                //���̶���    
                for(var i=0;i<scaleNumber - 1;i++){    
                    objScaleDiv = this.document.createElement("<div style='position:absolute;left:50;top:13;font-size:4pt;font-weight:lighter;color:#999999;width:3:'/>");    
                    objScaleDiv = objContainsDiv.appendChild(objScaleDiv);    
                    with(objScaleDiv){    
                        style.left = scaleLenth*(i + 1);    
                        innerText = "|";    
                    }    
                }
				objTrackBar.style.left=0;
            }    
                
            function createBar(){//��������    
                
                var objBarContainsDiv;    
                objBarContainsDiv = this.document.createElement("<div style='position:absolute;left:0;top:0;height:16;width:11;z-index:2;'/>");    
                    
                //������������    
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
                
            function setPosition(){//����trackPath��ʱ�򽫻����ƶ�����ǰλ��    
                    
                trackBarBeforeMoving();    
                //level.innerText = Math.round(parseInt(objTrackBar.style.left)*100/vaildLength) + "%";    
            gotoVolumn(Math.round(parseInt(objTrackBar.style.left)*100/vaildLength));
           
            }    
                
            function trackBarBeforeMove(){//�����ƶ�ǰ    
                vLeft = window.event.x - objTrackBar.style.pixelLeft;    
                objTrackBar.style.background = "#dddddd";    
                objTrackBar.setCapture();    
                objTrackBar.attachEvent("onmousemove", trackBarBeforeMoving);    
            }    
                
            function trackBarBeforeMoving(){//�����ƶ���    
                    
                var leftPoint;          
                var pointDividLength;    
                var vMousePositionX;    
                ///////////////////////////////////    
                if((event.x - objContainsDiv.offsetLeft - 8) > vaildLength || event.x<objContainsDiv.offsetLeft) return;    
                    
                ///////////////////////    
                    
                vMousePositionX = parseInt(event.x) - objContainsDiv.offsetLeft;    
                leftPoint = Math.floor(vMousePositionX/scaleLenth);//�������ĵ����    
                pointDividLength = leftPoint*scaleLenth + scaleLenth/2;    
                if(vMousePositionX < pointDividLength){//ճ������ߵ�    
                    objTrackBar.style.left = leftPoint*scaleLenth;    
                    //return;    
                }    
                if(vMousePositionX > pointDividLength){//ճ�����ұߵ�    
                    objTrackBar.style.left = (leftPoint+1)*scaleLenth;    
                    //return;    
                }    
                    
                ///////////////////////////////////    
                
                if(parseInt(objTrackBar.style.left)>vaildLength){//�Ƶ����ұ߽�    
                    objTrackBar.style.left = vaildLength;    
                }    
                    
                if(parseInt(objTrackBar.style.left)<0){//�Ƶ�����߽�    
                    objTrackBar.style.left = 0;    
                }    
				
                    
               //level.innerText = Math.round(parseInt(objTrackBar.style.left)*100/vaildLength) + "%";    
            }    
                
            function trackBarBeforeMouseup(){//������������    
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
var lastValue=0;  
var zf=0;          
function gotoVolumn(valuee)
{
	if(valuee==100)
	{	
		window.opener.top.cCcommonTool.StopPlay();
		return false;
	}
	if(valuee==0)
	{
		window.opener.top.cCcommonTool.StopPlay();
		var temp=window.opener.top.document.getElementById("recordfile").value;
		var ret=window.opener.top.cCcommonTool.BeginPlayEx(temp);
		return false;
	}	
	
	if((valuee-lastValue)>0)
	{
		zf=1;
	}
	else
	{
		zf=0;
	}
var valuechar=Math.abs(valuee-lastValue);
lastValue=valuee;
var times=Math.floor(valuechar/10)+1;
for(i=0;i<times;i++)
{
		if(zf>0)
		{
			window.opener.top.cCcommonTool.ForeFastPlay();
		}	
		else
	  {
		window.opener.top.cCcommonTool.BlackFastPlay();
		
		}
}
}
getNum();
function getNum()
{
var contact_id=window.opener.top.document.getElementById("lisenContactId").value;
if(contact_id=='')
{
contact_id='20090410KF00000004347';
}
var packet = new AJAXPacket("../../../npage/callbosspage/k021/getTotalNum.jsp","���ڴ���,���Ժ�...");
packet.data.add("retType" ,  "chkExample");
packet.data.add("contactId" ,contact_id);
core.ajax.sendPacket(packet,doProcessNavcomring,true);
packet =null;
}
  //��������ص�
function doProcessNavcomring(packet)	 
	 {
	 	
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    var totalnum = packet.data.findValueByName("totalnum"); 
	    if(retType=="chkExample"){
	    	var step=Math.floor(totalnum/10)+1;
	    	window.opener.top.parPhone.PlayStep=step;
	    }
	 }
	 
        </script>   
         
    </HEAD>    
    <BODY onload="loadPage()">    
        <div id="containsDiv" style="position:absolute;left:10;top:50;border:solid 0px #cccccc;width:280;height:23;background:#dddddd;">    
            <hr id="trackPath" size="1" color="#cccccc" style="position:absolute;top:16;height:3;border:groove 1px #eeeeee;background:#666666;z-index:1;">    
        </div>    
        <span id="level" style="position:absolute;left:100;top:30;width:50;font-size:9pt;color:red;"></span>    
    </BODY>    
</HTML>



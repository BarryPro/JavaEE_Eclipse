//�Ƿ���ڸ�ѡ��
var hasSelectOption = "1";
//��ǰ������span
var operateDiv = null;

with (document) {
	write("<STYLE TYPE='text/css'>");
	write(".parent { font: 12px/13px; Times; text-decoration: none; color: black;}");
	write(".child { font:12px/13px Times; display:none;color:black;}");
	write(".child_show { font:12px/13px Times; display:block;color:black;}");
	write(".item { color: black; text-decoration:none; cursor: hand;display: inline  }");
	write(".highlight { color: blue; text-decoration:none }");
	write(".icon { margin-right: 5 }")		
	write("</STYLE>");
}


/**
* ��ȡ�ӽڵ�
*/

function getChildren(par_id){
  var pardiv=document.getElementById('m'+par_id+'span');
  var packet = new AJAXPacket("/npage/callbosspage/callTrans/k029_mixedtree_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("nodeId",par_id);
  packet.data.add("nodeLevel",pardiv.nodeLevel);
  packet.data.add("inFlag",inFlag);
  packet.data.add("hasSelectNodes",parent.document.getElementById("node_Id").value);
  packet.data.add("lastChildRoute",pardiv.lastChildRoute);
  packet.data.add("hasSelectOption",hasSelectOption);
  core.ajax.sendPacket(packet,getChildCallBack,true);
	packet=null;

}

function getChildCallBack(packet){
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  var curPardiv=document.getElementById("m"+nodeId+"Child");  
  curPardiv.innerHTML = nodesHtml;
  var pardiv=document.getElementById('m'+nodeId+'span');
  pardiv.hasLoad='1';
  if(ids){
  	checkedSelected();
  }
}

//��¼��ʼ�����ĸ��ڵ�
var parentNodeId ;
//��ʼ�����ڵ㣬divId����¼������div��id��par_id����¼�����ڵ��ID��isVisual���������ʵ����ʵ����Ҫ�����ݿ� ��hasSelect���Ƿ���Ҫ��ѡ��
function initRootNodes(divId,par_id,isVisual,hasSelect,CalledNo,CityCode,UserClass,inFlag,node_id){ 
  hasSelectOption = hasSelect;
  parentNodeId = divId;
  var packet = new AJAXPacket("/npage/callbosspage/k171/k171_mixedtree_rpc.jsp?","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("CalledNo",CalledNo);
  packet.data.add("CityCode",CityCode);
  packet.data.add("UserClass",UserClass);
  packet.data.add("inFlag",inFlag);
  packet.data.add("nodeId",par_id);
  packet.data.add("nodeLevel","1");
  packet.data.add("inFlag",inFlag);
  packet.data.add("isRoot","1");
  packet.data.add("isVisual",isVisual);
  packet.data.add("hasSelectOption",hasSelectOption);
  packet.data.add("hasSelectNodes",node_id);
  core.ajax.sendPacket(packet,getInitCallBack,true);
	packet=null;
}



function getInitCallBack(packet){
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  var curPardiv=document.getElementById(parentNodeId);
  curPardiv.className='child_show';
  curPardiv.innerHTML = nodesHtml;
  if(ids){
  	checkedSelected();
  }
}


//ͼ��ת������Ҫ���߼�ת����ִ��
function hideOrShow_(par_id){
	var img1div=document.getElementById('m'+par_id+'Tree');
	var img2div=document.getElementById('m'+par_id+'Folder');
	var pardiv=document.getElementById('m'+par_id+'Child');
	var pardiv2=document.getElementById('m'+par_id+'span');
	if(pardiv){
		if(pardiv2.isOpen=='0'){
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tplus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lplus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/foldericon.gif";
			pardiv.style.display='none';
		}
		else{
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tminus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lminus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/openfoldericon.gif";
			pardiv.style.display='block';
		}
	}
}

function changeColor(node_id){
	if(operateDiv!=null&&operateDiv!=''){
		   var spandiv=document.getElementById(operateDiv);
		   if(spandiv!=null){
		   			spandiv.style.color = '#000000';
		   			spandiv.style.backgroundColor = '';
		   	}
		}
		operateDiv = 'm'+node_id+'span';
		var spandiv2=document.getElementById(operateDiv);
		if(spandiv2!=null){
		   			spandiv2.style.color = '#FFFFFF';
		   			spandiv2.style.backgroundColor = '#000BB0';
	}
}

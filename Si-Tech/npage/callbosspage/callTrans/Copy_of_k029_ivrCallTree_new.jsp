<%@ page language="java"  pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>    
    <HEAD>      
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/mixedtree.js" type=text/javascript></SCRIPT>
      </HEAD>
          
<BODY>           
<TABLE><TR><TD vAlign=top >
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top>
<DIV id="childTree">
	</DIV>
</TD>
        	
        </TR>
        
        </TABLE>
</BODY>        
</html>  
 <SCRIPT type=text/javascript>
    var ext2 = parent.document.form1.ext2.value;
    var typeFlag; 
    var toAthouDigitcode;
    var inFlag=parent.document.getElementById("inFlag").value;
    var CalledNo=parent.document.getElementById("CalledNo").value;
    var CityCode=parent.document.getElementById("CityCode").value;
    var UserClass=parent.document.getElementById("UserClass").value;	
    var ServiceNo=parent.document.getElementById("ServiceNo").value;
    var userTypeBegin=parent.document.getElementById("userTypeBegin").value; 
//看看是否能取到值
//alert("CalledNo"+CalledNo);
//alert("CityCode"+CityCode);
//alert("UserClass"+UserClass);

/*
   if(CalledNo == ''||CalledNo == undefined)
   {
        CalledNo = "10086";
   }
*/
	
	// 取消所有的checkbox选中
	function unCheckBoxBySelect(){
		//alert();
		var checkBoxItems = document.getElementsByTagName("input");  	
		for(var i=0;i<checkBoxItems.length;i++){
				if(checkBoxItems[i].type=='checkbox'&&checkBoxItems[i].checked==true){
						checkBoxItems[i].checked=false;
				}
		}
	}
	//取消
	function deleteBoxList(node_id)
	{
	   var par_object=parent.document.getElementById("show_Name");
	   var par_del_child=parent.document.getElementById("node_id");
	   var children = par_object.childNodes; 
	   deleteShowName(node_id);  
	   for(var i=0;i<children.length;i++){	
	     if(children[i].id==node_id){	
	       par_object.removeChild(children[i]); 
	     }
	   }
	   ext2=removeExt(ext2,node_id);
	   parent.document.form1.ext2.value=ext2;
	   var myselect=parent.document.form1.select_Name.options;
	   for(var i=0;i<myselect.length;i++){
	   		if(myselect[i].value==node_id){
	   				myselect.remove(i);
	   				break;
	   		}
	   }
	    
	}
	function sendData(ttansfercode,typeId,toAthouDigitcode,usertype){
	 //组织数据，转IVR,取得ttansfercode
		  parent.document.form1.ttansfercode.value=ttansfercode;
		  parent.document.form1.typeId.value=typeId;
		  parent.document.form1.DigitCode.value=toAthouDigitcode;
		  parent.document.form1.userType.value=usertype;
		  parent.document.form1.ext2.value=ext2;
		  //alert("parent.document.form1.ext2.value"+parent.document.form1.ext2.value);
	  
	}
	function img1Click(par_id){
	  changeColor(par_id);
		var pardiv=document.getElementById('m'+par_id+'span');
		//针对非叶子节点，打开加载数据
		if(pardiv.is_Leaf=='0'){
				if(pardiv.isOpen=='0'){
					if(pardiv.hasLoad=='0'){
						getChildren(par_id);
						pardiv.isOpen='1';
						//pardiv.hasLoad='1';
						hideOrShow_(par_id);
			  	}else{
			  		pardiv.isOpen='1';
			  		hideOrShow_(par_id);	  	  	
			  	}
		 	 	}else{		  		
		  		pardiv.isOpen='0';
		  		hideOrShow_(par_id);
		  	}			
		}else{
				var checkBoxItem = document.getElementById("chk"+par_id);
				if(checkBoxItem.checked==false){
					checkBoxItem.checked=true;
			  }else{
			    checkBoxItem.checked=false;
			  }
				checkBoxClick(par_id);
		}
	}
	function img2Click(par_id){
		img1Click(par_id);
	}
	function spanClick(par_id){
		//alert();
		changeColor(par_id);
		var pardiv=document.getElementById('m'+par_id+'span');
		//针对非叶子节点，打开加载数据
		if(pardiv.is_Leaf=='0'){
			//节点层数的限制
				if(pardiv.isOpen=='0'){
					if(pardiv.hasLoad=='0'){
						
						getChildren(par_id);
						pardiv.isOpen='1';
						//pardiv.hasLoad='1';
						hideOrShow_(par_id);
			  	}else{
			  		pardiv.isOpen='1';
			  		hideOrShow_(par_id);	  	  	
			  	}
		 	 	}else{		  		
		  		pardiv.isOpen='0';
		  		hideOrShow_(par_id);
		  	}
			
		}else{
		
			var checkBoxItem = document.getElementById("chk"+par_id);
			if(checkBoxItem.checked==false){
					checkBoxItem.checked=true;
			}else{
			    checkBoxItem.checked=false;
			}
			checkBoxClick(par_id);	
		}	
	}
	
	function spandblClick(par_id){
		
	}
	function checkBoxClick(id){
		var pardiv=document.getElementById('m'+id+'span');
		var inReg;
    var arr;
    var isLeaf=pardiv.typeid;
    var digitcode=pardiv.digitcode;
    var ttansfercode=pardiv.ttansfercode;
    var typeId=pardiv.typeid;
    var usertype=pardiv.usertype;
		changeColor(id);
		var checkBoxItem = document.getElementById("chk"+id);
		
		
		if(checkBoxItem.checked==false)
   	{ 
      	deleteBoxList(id);      
   	}else{ 		
   		if(isLeaf=='2001'||isLeaf=='2002'){
    		inReg="00";
 	 		}
 			if(isLeaf=='2003'||isLeaf=='2004'){
    		inReg="01";
 			}
   		var checkBoxItems = document.getElementsByTagName("input");
			var arr = new Array();
   		var m = 0;
   	
			for(var i=0;i<checkBoxItems.length;i++){
				if(checkBoxItems[i].type=='checkbox'&&checkBoxItems[i].checked==true){
					arr[m] = checkBoxItems[i].value;
					m++;
				}
			}
   		if(m==1){
				typeFlag=document.getElementById('m'+arr[0]+'span').typeid;
    		ext2=id+"~"+inReg+"^"+CityCode+"^"+UserClass+"^"+userTypeBegin+"^"+digitcode+"^"+ServiceNo;
    		if(typeFlag=='2001'||typeFlag=='2003'){
       		toAthouDigitcode=digitcode;
    		}
    		else{
       		toAthouDigitcode=digitcode.substr(0,2);
    		}
    		showNodeIdList('',id,ttansfercode,typeId,toAthouDigitcode,usertype);
			}
	 		if(m>1){
	 			if(arr[0]==checkBoxItem.value){
	 				typeFlag=document.getElementById('m'+arr[1]+'span').typeid;
	 		  }else{
	 			  typeFlag=document.getElementById('m'+arr[0]+'span').typeid;
	 		  }
				if(typeFlag=='2001'||typeFlag=='2003'){
         	checkBoxItem.checked=false; 
  			}
  			if(typeFlag=='2002'||typeFlag=='2004'){
  				//外呼排除多选
	 		  	var outflag = top.opener.outCallFlag;
	 		  	if(outflag!=undefined&&outflag==1){
	 		  		checkBoxItem.checked=false; 
	 		  	}
      		else if(isLeaf=='2001'||isLeaf=='2003'){
          	checkBoxItem.checked=false;
      	  }
      	  else{
     	   		ext2=ext2+","+id+"~"+inReg+"^"+CityCode+"^"+UserClass+"^"+userTypeBegin+"^"+digitcode+"^"+ServiceNo; 	
     	   		showNodeIdList('',id,ttansfercode,typeId,toAthouDigitcode,usertype); 
     	    }
     	 		
   			}
			}  
		}

		//alert(parent.document.form1.node_Id.value);
 		//alert(parent.document.form1.node_Name.value);
 		//alert(parent.document.form1.show_Name.value);
 		//alert(parent.document.form1.ext2.value);

	}
         //构建一个动态树
function initBaseTree()
{
     iniRootNodes('baseTree','0','0','1');
}    
        </SCRIPT> 

<SCRIPT type=text/javascript> 

//将树的信息显示在页面下方
     function showNodeIdList(allCheckItem,id,ttansfercode,typeId,toAthouDigitcode,usertype){
      sendData(ttansfercode,typeId,toAthouDigitcode,usertype); 
     //var els=parent.document.getElementsByTagName("span");
     //得到选中节点名字
     var pardiv=document.getElementById('m'+id+'span');
     var onCheckItemName=pardiv.servicename;
     var isLeaf=pardiv.typeid;
     //将数据显示
     if(!isInShowName(id)){
      parent.document.form1.node_Id.value=parent.document.form1.node_Id.value+","+id;
     //parent.show_Name.innerHTML=parent.show_Name.innerHTML+"<span id='"+id+"'>"+id+'→'+onCheckItemName+'<br></span>';
      var mytext=id+'→'+onCheckItemName;
      var myvalue=id;
      var myOption = new Option(mytext,myvalue);
      //alert("parent.select_Name"+parent.document.form1.select_Name);
       parent.document.form1.select_Name.options.add(myOption);
      //var aa=parent.document.form1.select_Name.options.add(new Option(mytext,myvalue));
      //alert("aa"+aa);
      parent.document.form1.show_Name.value=parent.document.form1.show_Name.value+","+id+'→'+onCheckItemName;
      parent.document.getElementById("node_Name").value=parent.document.form1.show_Name.value;
      //parent.document.form1.node_Name.value=parent.show_Name.innerHTML; 
     }
    }
     
     initBaseTree();
  //从数组中移出选定的项，返回剩余的项
   function removeExt(ext,id){
     var dataStr='';
     var str=ext.split(",");
     if(ext==''||id==''||ext==undefined ||id==undefined){return false;}
     for(var i=0;i<str.length;i++){
       if(str[i].substr(0,str[i].indexOf("~"))==id){
          dataStr=str.slice(0,i)+','+str.slice(i+1);
          return dataStr;   
       }
     }    
   }
   /*
  * 从数组中删除选中相同的数据
  */
  function deleteShowName(node_id){
  var elsId=parent.document.getElementById("node_Id").value;
  var elsName = parent.document.getElementById("node_Name").value;
  var elsArray=elsId.split(",");
  var elsNameArray = elsName.split(",");
  var pardiv=document.getElementById('m'+node_id+'span');
  var node_name = pardiv.servicename;
  node_name = node_id+"→"+node_name;
  if(elsId==null||elsId==undefined)return false;
  for(var i=1;i<elsArray.length;i++){
      if(elsArray[i]==node_id){
	       elsArray.splice(i,1);
	       parent.document.form1.node_Id.value=elsArray.toString();
	   }
	  }
for(var i=1;i<elsNameArray.length;i++){
      if(elsNameArray[i]==node_name){
	       elsNameArray.splice(i,1);
	       parent.document.form1.node_Name.value=elsNameArray.toString();
	       parent.document.form1.show_Name.value=elsNameArray.toString();
   }
  }
  }
  
  /*
	*判断节点ID是否在选中的集合中
	*/
	function isInShowName(node_id){
	 var els =parent.document.form1.select_Name.options;
	 if(els.length<0)return false;
	   for(var i=0;i<els.length;i++){
	   if(els[i].value==node_id){
	     return true;
	   }
	 }
	 return false;
	}  
</SCRIPT>  
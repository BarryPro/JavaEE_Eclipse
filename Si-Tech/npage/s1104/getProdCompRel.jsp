<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
   	String majorProductId = WtcUtil.repNull(request.getParameter("majorProductId"));
   	System.out.println("-----------------------------getProdCompRel.jsp1--------------------------------------");  
   	System.out.println(majorProductId);
%>

 <wtc:utype name="sGetCompRel" id="retVal" scope="end"> 
	<wtc:uparam value="<%=majorProductId%>" type="LONG"/>   
</wtc:utype>
<%
	String retcode = retVal.getValue(0);
	Map  hashMap  = new HashMap(103);
	Map  dependMap  = new HashMap(103); //存放被依赖关系
	
	

	if(retcode.equals("0")){
			 
		
			 
			for(int i=0;i<retVal.getUtype("2").getSize();i++)
			{
			 	  UType utypeOneLevel = retVal.getUtype("2."+i); 
			 	  
					String  offerAId = utypeOneLevel.getValue(0).trim();
					String  offerZId = utypeOneLevel.getValue(1).trim();
					String  relationType = utypeOneLevel.getValue(2).trim();
					
					
					hashMap.put(offerAId,offerAId);		
					dependMap.put(offerZId,offerZId);					
					if(relationType.equals("1"))//关系为互斥
					{
					   hashMap.put(offerZId,offerZId);	
					}
			}
	}
%>
<script language="javaScript">
	
	  var comPordHash = new Object();
	  var comProdDepHash =  new Object(); //产品间关系
<%
		Iterator dependIt = dependMap.keySet().iterator();
		while(dependIt.hasNext())
		{
		  String str = (String)dependIt.next();
%>
	 		comProdDepHash['<%=str%>'] = [];
<%	}

		Iterator it = hashMap.keySet().iterator();
		while(it.hasNext())
		{
		  String str = (String)it.next();
%>
	 		comPordHash['<%=str%>'] = [[],[]];
<%	}

	if(retcode.equals("0")){	

			for(int i=0;i<retVal.getUtype("2").getSize();i++)
			{
			  UType utypeOneLevel = retVal.getUtype("2."+i); 
			 	  
					String  offerAId = utypeOneLevel.getValue(0).trim();
					String  offerZId = utypeOneLevel.getValue(1).trim();
					String  relationType = utypeOneLevel.getValue(2).trim();
		%>
				   comPordHash['<%=offerAId%>'][0].push('<%=offerZId%>');
				   comPordHash['<%=offerAId%>'][1].push('<%=relationType%>');
		<%
		
		      if(relationType.equals("1"))//关系为互斥
		      {%>
		      
		       comPordHash['<%=offerZId%>'][0].push('<%=offerAId%>');
				   comPordHash['<%=offerZId%>'][1].push('<%=relationType%>');
		      <%
		      }
		     else if(relationType.equals("0")){ //关系为依赖
		%>
						comProdDepHash['<%=offerZId%>'].push('<%=offerAId%>');
		<%			
					}
				
				}
			}
		%>	
		
function checkProdCompRel(_this){
	var clickId = _this.id;
	var items = new Object();
	var exitsFlag = 0;
	
	if(_this.checked == false){
			if(typeof(comProdDepHash[clickId]) !="undefined" && comProdDepHash[clickId].length >0){
				$.each(comProdDepHash[clickId],function(i,n){   
					if($("#"+n)[0].checked == true){
						rdShowMessageDialog($("#"+n).attr("name").substring(9)+"依赖于"+$("#"+clickId).attr("name").substring(9)+",请先取消"+$("#"+n).attr("name").substring(9)+"!");
						$("#"+clickId).attr('checked',true);
						showDetailProd2(clickId,$("#"+clickId).attr("name").substring(9),$("#"+clickId));
						exitsFlag = 1;
						return false;
					}
				});	
				if(exitsFlag == 1){
					return false;
				}	
			}	
	}
	
	if(typeof(comPordHash[clickId]) != "undefined"){
		items = comPordHash[clickId];
		if(_this.checked == true){
			$.each(items[0],function(i,n){
				if(items.raletionWith(n) == 0 && $("#"+n)[0].checked == false)
		     {
		     	 rdShowMessageDialog($("#"+clickId).attr("name").substring(9)+"依赖于"+$("#"+n).attr("name").substring(9)+",请先选择"+$("#"+n).attr("name").substring(9)+"!");
		     	 $("#"+clickId).attr('checked','');
		     	 $("#pro_detail_"+clickId).remove();
		     	 return false;
		     }	
		  }); 
		  $.each(items[0],function(i,n){   
				if(items.raletionWith(n) == 1 && $("#"+clickId)[0].checked == true){
					if($("#"+n)[0].checked == true){
						$("#"+n).attr('checked','');
					}
					$("#"+n).attr('disabled',true);
					var temp = parseInt($("#"+n).attr('_mutexNum'));
					$("#"+n).attr('_mutexNum',temp+1);
				}
			});
		}
		else{
			$.each(items[0],function(i,n){
				if(items.raletionWith(n) == 1){
					var temp = parseInt($("#"+n).attr('_mutexNum'));
					$("#"+n).attr('_mutexNum',temp-1);
					if(temp-1 == 0){
						$("#"+n).attr('disabled',false);
					}	
				}	
			});	
		}
	}	
}		

function initProdRel(prodId){
	
	var items = new Object();
	if(typeof(comPordHash[prodId]) != "undefined"){
		items = comPordHash[prodId];
		if($("#"+prodId)[0].checked == true){
		  $.each(items[0],function(i,n){   
				if(items.raletionWith(n) == 1){
					$("#"+n).attr('disabled',true);
					var temp = parseInt($("#"+n).attr('_mutexNum'));
					$("#"+n).attr('_mutexNum',temp+1);
				}
			});
		}
	}	
}
</script>




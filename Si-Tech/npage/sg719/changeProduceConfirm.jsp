<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/common/qcommon/print_include.jsp"%>
<%
	System.out.println("<<<---------------��Ʒ���ȷ��-------------------->>>"); 
	String sysAcceptl = WtcUtil.repNull(request.getParameter("sysAcceptl"));
	System.out.println("-----------------------------sysAcceptl----------------------"+sysAcceptl);			 
	String opName=WtcUtil.repNull(request.getParameter("opName"));
	//String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String closeId=request.getParameter("closeId");
	String prtFlag=WtcUtil.repNull(request.getParameter("prtFlag"));
	String offerSrvId=WtcUtil.repNull(request.getParameter("offerSrvId"));
  System.out.println("======offerSrvId======"+offerSrvId);	
	int hasservOrderData = 0;
	int hasservOrderSlaInfo = 0;                
	int hasUserRelaInfo = 0;
	int isCDMA = 0;
	String currentTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
	String currentTime1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()); //��ǰʱ��
	System.out.println("-----------------------------currentTime1----------------------"+currentTime1);			
	HashMap son_Parent_Map = new HashMap();
	String serviceNo = WtcUtil.repNull(request.getParameter("selNum"));
	String Band_Id = WtcUtil.repNull(request.getParameter("Band_Id"));
	String custOrderId  = WtcUtil.repNull(request.getParameter("custOrderId")); //�ͻ�������
	String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));
	String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId")); //�ͻ���������ID
System.out.println("�ͻ���������ID==="+orderArrayId);	
	String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));		//�ͻ����񶨵���	
	if(servOrderId.equals(""))
	{
		servOrderId="0";
	}
System.out.println("�ͻ����񶨵���="+servOrderId);	
	String custId =WtcUtil.repNull(request.getParameter("gCustId"));
System.out.println("============custId======="+custId);	
	String servBusiId=WtcUtil.repNull(request.getParameter("servBusiId"));
System.out.println("============servBusiId======="+servBusiId);	
	//---------------------����Ա��Ϣ----------------------
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String ipAddr = (String)session.getAttribute("ipAddr");
	//String objectId = (String)session.getAttribute("objectId");
	String objectId = (String)session.getAttribute("groupId");
	//String siteId = (String)session.getAttribute("siteId");
	String siteId = (String)session.getAttribute("groupId");
	//String bureauId = (String)session.getAttribute("bureauId");//-----
	String bureauId = (String)session.getAttribute("regionCode");
	String opNote = "����Ա"+workNo+"�Կͻ�"+custId+"���в�Ʒ���";
	String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));	
	//---------------------ѡ�������Ʒ--------------------
	String[] sonParentArr = request.getParameter("sonParentArr").split(","); //����Ʒ��ʶ~Ԫ��ʵ����ʶ
	for(int i=0;i<sonParentArr.length;i++)
	{
			String[] temp = sonParentArr[i].split("~");
			son_Parent_Map.put(temp[0],temp[1]);
	}
	
	HashMap instanceMap = new HashMap();
	String[] offerIdArr = request.getParameter("offerIdArr").split(",");		
	String[] offerEffectTime =request.getParameter("offerEffectTime").split(",");
	String[] offerExpireTime = request.getParameter("offerExpireTime").split(",");
	String[] offerStatu = WtcUtil.repNull(request.getParameter("offerStatu")).split(",");
	String[] discountPlanInstId = new String[offerIdArr.length]; 
	String[] offerIntIdArr= WtcUtil.repNull(request.getParameter("offerIntIdArr")).split(",");//����Ʒʵ����ID
	
 
//--------------------------SLA��Ϣ-----------------------
	String servsla_name = WtcUtil.repNull(request.getParameter("servsla_name"));		//ָ������
	String servsla_value = WtcUtil.repNull(request.getParameter("servsla_value"));//ָ��ֵ
	String servsla_seq = WtcUtil.repNull(request.getParameter("servsla_seq"));    //ָ�����
	String servsla_level = WtcUtil.repNull(request.getParameter("servsla_level"));  //����ˮƽ����
	int hasSLAInfo = 1;
	if(servsla_name ==""&&servsla_value ==""&&servsla_seq ==""&&servsla_level =="")
	{
		hasSLAInfo = 0;
	}
	//--------------------------ѡ��Ĳ�Ʒ---------------------
	String[] attrFlag=WtcUtil.repNull(request.getParameter("attrFlag")).split(",");
	String[] prodIdArr = WtcUtil.repNull(request.getParameter("productIdArr")).split(",");
	String[] prodEffectDate = WtcUtil.repNull(request.getParameter("prodEffectDate")).split(",");
	String[] prodExpireDate = WtcUtil.repNull(request.getParameter("prodExpireDate")).split(",");
	String[] isMainProduct = WtcUtil.repNull(request.getParameter("isMainProduct")).split(",");
	String[] productStatu = WtcUtil.repNull(request.getParameter("productStatu")).split(",");
	String[] proOptFlag=WtcUtil.repNull(request.getParameter("proOptFlag")).split(",");//��Ʒ��������
	String[] proAttrOptFlag=WtcUtil.repNull(request.getParameter("proAttrOptFlag")).split(",");//��Ʒ���Բ�������	
	String[] newStatu=WtcUtil.repNull(request.getParameter("newStatu")).split(",");//������Ĳ�Ʒ״̬
	String[] proIntIdArr=WtcUtil.repNull(request.getParameter("proIntIdArr")).split(",");//��Ʒʵ��ID
	String[] parentInstId=WtcUtil.repNull(request.getParameter("parentInstId")).split(",");//�ϼ���Ʒʵ��ID
	String[] prodNameArr=request.getParameter("prodNameArr").split(",");//��Ʒ����
	String adslPrint=request.getParameter("adslPrint");
System.out.println("====adslPrint==="+adslPrint);	
	String offerDis= request.getParameter("offerDis");
	String printOptInfo="";
	for(int i=0;i<proOptFlag.length;i++)
	{
			String endFlag="^0|";
			if(!printOptInfo.equals(""))
			{
					endFlag="^1|";
			}
			if(proOptFlag[i].equals("1"))
			{
					printOptInfo=printOptInfo+"�¹��˲�Ʒ"+prodNameArr[i]+endFlag;
			}else if(proOptFlag[i].equals("3"))
			{
					printOptInfo=printOptInfo+"�˶��˲�Ʒ"+prodNameArr[i]+endFlag;
			}	
	}
	if(!printOptInfo.equals(""))
	{
		printOptInfo=printOptInfo.substring(0,printOptInfo.length()-1);
	}
	if(printOptInfo.equals("")&& adslPrint.equals(""))
	{
		printOptInfo="δ���κβ���";
	}		
//--------------------------��Ʒ����---------------------
	String prodAttrValueArr=WtcUtil.repNull(request.getParameter("prodAttrValueArr"));//��Ʒ�����ܴ�
	String[] proAttrArr=prodAttrValueArr.split("@");//ÿ����Ʒ����������
	for(int i=0;i<proAttrArr.length;i++)
	{
			if(proAttrArr[i].equals("M"))
			{
				proAttrArr[i]="";
			}
	}
	String[] prodAttrIdArr = new String[]{};
	if(!WtcUtil.repNull(request.getParameter("prodAttrIdArr")).equals(""))
	{
	   prodAttrIdArr = WtcUtil.repNull(request.getParameter("prodAttrIdArr")).split(",");
	}
		String [] seqArr = new String[prodIdArr.length];//��Ʒʵ��id
		for(int i=0;i<prodIdArr.length;i++)
		{
		
%>	
	<wtc:service name="sDynSqlCfm" outnum="1">
	<wtc:param value="12"/>
</wtc:service>	
<wtc:array id="rows" scope="end" />
<%
		if(retCode.equals("000000")&&rows.length > 0)
		{
			seqArr[i] = rows[0][0];
		}
	}
	
	

%>		 
<wtc:utype name="sProdChgCfm" id="retVal" scope="end" >  
<wtc:uparams name="ctrlInfo" iMaxOccurs="1">
		<wtc:uparam value="0" type="string"/>
	</wtc:uparams>	
	<wtc:uparams name="batchDataList" iMaxOccurs="1">
		<wtc:uparams name="batchData" iMaxOccurs="-1">
			<wtc:uparam value="0" type="long"/>
			<wtc:uparam value="0" type="string"/>
			<wtc:uparam value="0" type="string"/>
		</wtc:uparams>	
	</wtc:uparams>	
<wtc:uparams name="msgBodyType" iMaxOccurs="1">	              
<wtc:uparams name="oprInfo" iMaxOccurs="1">                                   
	<wtc:uparam value="<%=sysAcceptl%>" type="long"/>                                         
	<wtc:uparam value="<%=opCode%>" type="string"/>                                    
	<wtc:uparam value="<%=workNo%>" type="string"/>                             
	<wtc:uparam value="<%=password%>" type="string"/>                           
	<wtc:uparam value="<%=ipAddr%>" type="string"/>                             
	<wtc:uparam value="<%=siteId%>" type="string"/>                            
	<wtc:uparam value="<%=currentTime%>" type="string"/>                                       
	<wtc:uparam value="<%=regionCode%>" type="string"/>                         
	<wtc:uparam value="<%=opNote%>" type="string"/>                             
	<wtc:uparam value="<%=siteId%>" type="string"/>                           
	<wtc:uparam value="<%=objectId%>" type="string"/>                           
</wtc:uparams>                                                               
<wtc:uparams name="custOrder" iMaxOccurs="1">                                 
	<wtc:uparams name="custOrderMsg" iMaxOccurs="1">                            
		<wtc:uparam value="<%=custOrderId%>" type="string"/>                      
	</wtc:uparams>                                                              
	<wtc:uparams name="orderArrayList" iMaxOccurs="1">                          
		<wtc:uparams name="orderArrayListContainer" iMaxOccurs="-1">              
			<wtc:uparams name="orderArrayMsg" iMaxOccurs="1">                       
				<wtc:uparam value="<%=orderArrayId%>" type="string"/>                 
			</wtc:uparams>                                                          
			<wtc:uparams name="servOrderList" iMaxOccurs="1">                       
				<wtc:uparams name="servOrderListContainer" iMaxOccurs="-1">           
					<wtc:uparams name="servOrderMsg" iMaxOccurs="1">                    
						<wtc:uparam value="<%=servOrderId%>" type="string"/>                             
						<wtc:uparam value="0" type="string"/>                             
						<wtc:uparam value="0" type="string"/>
						<wtc:uparam value="<%=offerSrvId%>" type="long"/>  <!-- �û�ID-->                               
						<wtc:uparam value="<%=serviceNo%>" type="string"/>                
						<wtc:uparam value="0" type="int"/>                                
						<wtc:uparam value="0" type="int"/>                                
						<wtc:uparam value="0" type="long"/>                               
						<wtc:uparam value="110" type="int"/>                              
						<wtc:uparam value="<%=currentTime%>" type="string"/>                             
						<wtc:uparam value="0" type="int"/>                                
						<wtc:uparam value="<%=servBusiId%>" type="string"/>                     
						<wtc:uparam value="N" type="string"/>                             
						<wtc:uparam value="0" type="string"/>                             
						<wtc:uparam value="20500101 00:00:0" type="string"/>                             
						<wtc:uparam value="0" type="string"/>                             
						<wtc:uparam value="1" type="int"/>                                
						<wtc:uparam value="0" type="string"/>                             
						<wtc:uparam value="0" type="string"/>                             
						<wtc:uparam value="0" type="int"/>                                
						<wtc:uparam value="1" type="int"/>                                
						<wtc:uparam value="Y" type="string"/>                             
						<wtc:uparam value="mshow" type="string"/>                
						<wtc:uparam value="111" type="string"/>                   
					</wtc:uparams>  				                                                    
					<wtc:uparams name="servOrderDataList" iMaxOccurs="1">  
<%
						 if(hasservOrderData != 0){
%>						             
						<wtc:uparams name="servOrderData" iMaxOccurs="-1">                
							<wtc:uparam value="999" type="long"/>                           
							<wtc:uparam value="0" type="int"/>                              
							<wtc:uparam value="twx" type="string"/>                         
						</wtc:uparams>   
<%
						 }
%>						                                                 
					</wtc:uparams>                                                      
					<wtc:uparams name="servOrderSlaList" iMaxOccurs="1">  
<%
					if(hasSLAInfo == 1){
%>						   				           
						<wtc:uparams name="servOrderSlaInfo" iMaxOccurs="-1">             
							<wtc:uparam value="0" type="string"/>                           
							<wtc:uparam value="1" type="int"/>                              
							<wtc:uparam value="2" type="int"/>               
							<wtc:uparam value="100" type="double"/>	        
						</wtc:uparams> 	
<%
					}
%>										                                                   
					</wtc:uparams>                                                      
					<wtc:uparams name="servOrderBookingMsg" iMaxOccurs="1">             
						<wtc:uparam value="0" type="string"/>                             
						<wtc:uparam value="20090101 00:00:00" type="string"/>             
						<wtc:uparam value="20090101 00:00:00" type="string"/>             
					</wtc:uparams> 					                                                     
					<wtc:uparams name="servOrderExcpInfo" iMaxOccurs="1">               
						<wtc:uparam value="0" type="string"/>                             
						<wtc:uparam value="0" type="int"/>                                
						<wtc:uparam value="test" type="string"/>                          
						<wtc:uparam value="OK" type="string"/>                            
						<wtc:uparam value="<%=workNo%>" type="string"/>                   
					</wtc:uparams>                                                      
				</wtc:uparams>                                                        
			</wtc:uparams>                                                          
		</wtc:uparams>                                                            
	</wtc:uparams>                                                              
</wtc:uparams>                                                                
<wtc:uparams name="customer" iMaxOccurs="1">                                  
	<wtc:uparams name="custDoc" iMaxOccurs="1">                                 
		<wtc:uparams name="custDocBaseInfo" iMaxOccurs="1">                       
			<wtc:uparam value="<%=custId%>" type="long"/>                           
		</wtc:uparams>                                                            
	</wtc:uparams>                                                              
	<wtc:uparams name="userInfoList" iMaxOccurs="1">                            
		<wtc:uparams name="userInfo" iMaxOccurs="-1">                             
			<wtc:uparams name="userBaseInfo" iMaxOccurs="1">    <!-- �û�������Ϣ-->     
				<wtc:uparam value="<%=serviceNo%>" type="string"/>               
				<wtc:uparam value="<%=offerSrvId%>" type="long"/>  <!-- �û�ID-->                       
				<wtc:uparam value="<%=Band_Id%>" type="string"/>
        <wtc:uparam value="" type="string"/>        <!-- �û��ڲ�11λ����-->
        <wtc:uparam value="<%=siteId%>" type="string"/> 
        <wtc:uparam value="<%=custId%>" type="long"/>                                                       
			</wtc:uparams>                                                                                                     
			<wtc:uparams name="discountInfoList" iMaxOccurs="1">     			        			                                                
			</wtc:uparams>                                         			          
			<wtc:uparams name="userRelaInfoList" iMaxOccurs="1"> <!-- �û���ϵ��Ϣ�б�-->
				<%
				if(hasUserRelaInfo == 1){
				%>				
				<wtc:uparams name="userRelaInfo" iMaxOccurs="-1">
					<wtc:uparam value="1" type="string"/>
					<wtc:uparam value="11211" type="string"/>
					<wtc:uparam value="111222" type="long"/>
					<wtc:uparam value="1" type="string"/>
					<wtc:uparam value="20081005 00:00:00" type="string"/>
					<wtc:uparam value="20081005 00:00:00" type="string"/>
				</wtc:uparams>
				<%
				}
				%>				
			</wtc:uparams>
			<wtc:uparams name="productList" iMaxOccurs="1">
<%
int tempCount = 0;
for(int i=0;i<prodIdArr.length;i++)
				{
									if(proOptFlag[i].equals("5")){
									tempCount++;
									}
			}	
int countSumFv = 0;
String proOptFlag_t    = "";
String offerIntIdArr_t[] =  new String[tempCount];
String proIntIdArr_t[]   =  new String[tempCount];
String prodEffectDate_t[]=  new String[tempCount]; //��ʼʱ��
String prodExpireDate_t[]=  new String[tempCount]; //����ʱ��
String newStatu_t[]      =  new String[tempCount];
String isMainProduct_t[] =  new String[tempCount];
String parentInstId_t[]  =  new String[tempCount];
String attrFlag_t[]      =  new String[tempCount];
String prodIdArr_t[] =  new String[tempCount];
String proAttrArr_t[] =  new String[tempCount];
String proAttrOptFlag_t[] =  new String[tempCount];
String tempTimeStr[] = new String[tempCount];


				for(int i=0;i<proOptFlag.length;i++)
				{
				System.out.println("-------------------proOptFlag["+i+"]--------------"+proOptFlag[i]);
									if(proOptFlag[i].equals("5")){
									
										proOptFlag[i] = "3";
										proOptFlag_t     = "1";         
										System.out.println("-----------------offerIntIdArr_t[0]-------------"+offerIntIdArr_t[0]);
										System.out.println("-----------------offerIntIdArr["+i+"]-------------"+offerIntIdArr[i]);
										offerIntIdArr_t[countSumFv]  = offerIntIdArr[i] ;      
										proIntIdArr_t[countSumFv]    = proIntIdArr[i]   ;  
										   
										prodIdArr_t[countSumFv]      = prodIdArr[i]     ;     
										System.out.println("--------------prodEffectDate[i]---------------"+prodEffectDate[i]);  
										tempTimeStr = prodEffectDate[i].split("#");
										System.out.println("--------------tempTimeStr[0]---------------"+tempTimeStr[0]);  
										System.out.println("--------------tempTimeStr[1]---------------"+tempTimeStr[1]);  
										prodEffectDate_t[countSumFv] = tempTimeStr[1];   
										System.out.println("--------------prodEffectDate_t["+countSumFv+"]---------------"+prodEffectDate_t[countSumFv]);  
										prodEffectDate[i] = tempTimeStr[0];
										System.out.println("--------------prodEffectDate[i]---------------"+prodEffectDate[i]);  
										prodExpireDate_t[countSumFv] =prodExpireDate[i];
										prodExpireDate[i] = currentTime1;
										newStatu_t[countSumFv]       = "A"      ;     
										isMainProduct_t[countSumFv]  = isMainProduct[i] ;     
										parentInstId_t[countSumFv]   = parentInstId[i]  ;     
										attrFlag_t[countSumFv]       = attrFlag[i]      ;   
										proAttrArr_t[countSumFv] = proAttrArr[i];
										proAttrOptFlag_t[countSumFv] = proAttrOptFlag[i];
										countSumFv++;
										newStatu[i]="a";
										
System.out.println("------------------------------proOptFlag     ["+i+"]----------------"+proOptFlag[i]      );
System.out.println("------------------------------offerIntIdArr  ["+i+"]----------------"+offerIntIdArr[i]   );
System.out.println("------------------------------proIntIdArr    ["+i+"]----------------"+proIntIdArr[i]     );
System.out.println("------------------------------prodIdArr      ["+i+"]----------------"+prodIdArr[i]       );
System.out.println("------------------------------type           ["+i+"]----------------"         );
System.out.println("------------------------------currentTime    ["+i+"]----------------"+currentTime      );
System.out.println("------------------------------prodEffectDate ["+i+"]----------------"+prodEffectDate[i]  );
System.out.println("------------------------------prodExpireDate ["+i+"]----------------"+prodExpireDate[i]  );
System.out.println("------------------------------newStatu       ["+i+"]----------------"+newStatu[i]        );
System.out.println("------------------------------prodExpireDate ["+i+"]----------------"+prodExpireDate[i]  );
System.out.println("------------------------------prodEffectDate ["+i+"]----------------"+prodEffectDate[i]  );
System.out.println("------------------------------isMainProduct  ["+i+"]----------------"+isMainProduct[i]   );
System.out.println("------------------------------parentInstId   ["+i+"]----------------"+parentInstId[i]    );
System.out.println("------------------------------attrFlag       ["+i+"]----------------"+attrFlag[i]        );

									}
									
									
									
					String parentId = (String)son_Parent_Map.get(prodIdArr[i]);
					if(!prodIdArr[i].equals("mshow"))
					{
								if(prodIdArr[i].indexOf("A") != -1){
										prodIdArr[i] = prodIdArr[i].split("A")[1];
									}	

			%>				
				<wtc:uparams name="product" iMaxOccurs="-1">
					<wtc:uparams name="productBaseInfo" iMaxOccurs="1">
						<wtc:uparam value="<%=proOptFlag[i]%>" type="string"/>
						<wtc:uparam value="<%=offerIntIdArr[i]%>" type="string"/>  <!-- ����Ʒʵ��ID-->
						<wtc:uparam value="<%=proIntIdArr[i]%>" type="string"/>     <!-- ��Ʒʵ��ID-->
						<wtc:uparam value="<%=prodIdArr[i]%>" type="string"/>
						<wtc:uparam value="0" type="string"/>     <!-- �ͻ�Э���ʶ-->
						<wtc:uparam value="<%=currentTime%>" type="string"/>
						<wtc:uparam value="<%=prodEffectDate[i]%>" type="string"/><!--��ʼʱ��--> 
						<wtc:uparam value="<%=prodExpireDate[i]%>" type="string"/><!--����ʱ��--> 
						<wtc:uparam value="<%=newStatu[i]%>" type="string"/>                      
						<wtc:uparam value="<%=prodExpireDate[i]%>" type="string"/><!--����ʱ��--> 
						<wtc:uparam value="<%=prodEffectDate[i]%>" type="string"/><!--��ʼʱ��--> 
						<wtc:uparam value="<%=isMainProduct[i]%>" type="string"/>
						<wtc:uparam value="<%=parentInstId[i]%>" type="string"/>   <!--  �ϼ���Ʒʵ��ID-->
						<wtc:uparam value="<%=attrFlag[i]%>" type="string"/>		<!--   ���ϲ�Ʒ��־-->
					</wtc:uparams>					
					<wtc:uparams name="productAttrList" iMaxOccurs="1">
<%
				  	System.out.println("liubo123   prodExpireDate=="+prodExpireDate[i]);
				  	String[] proAttrSignal=proAttrArr[i].split(",");//ÿ����Ʒ�ĵ���������
						int num=proAttrSignal.length;
						if(proAttrArr[i].equals(""))
						{
						  num=0;
						}			  	
						String[] attrId=new String[num];
						String[] attrVal=new String[num];
						for(int k=0;k<num;k++)
						{
							String [] finalArr=proAttrSignal[k].split("~");
							attrId[k]=finalArr[0];
							attrVal[k]=finalArr[1];
							if(attrVal[k].equals("M^"))
							  attrVal[k]="";
							  
							  System.out.println("$$$$$$$$$$$$$$$$$$$$---"+prodExpireDate[i]);
%>							
						<wtc:uparams name="productAttr" iMaxOccurs="-1">  <!-- ��Ʒ�����б�-->
	                 <wtc:uparam value="<%=proAttrOptFlag[i]%>" type="string"/>
	                 <wtc:uparam value="<%=attrId[k]%>" type="string"/>
	                 <wtc:uparam value="<%=attrVal[k]%>" type="string"/>
	                 <wtc:uparam value="<%=prodEffectDate[i]%>" type="string"/>
	                 <wtc:uparam value="<%=prodExpireDate[i]%>" type="string"/>                                 
						</wtc:uparams>
<%
						}
%>						
					</wtc:uparams>
					<wtc:uparams name="productGroupList" iMaxOccurs="1">   <!-- ��ƷȺ���б�-->
						<wtc:uparams name="productGroup" iMaxOccurs="-1">
							<wtc:uparam value="0" type="string"/>
						</wtc:uparams>
					</wtc:uparams>
				</wtc:uparams>
<%         
				}
				}
				
	for(int iw=0;iw<offerIntIdArr_t.length;iw++){
	System.out.println(iw+"-------------------------5------------------------����"+proOptFlag_t);
	
					String parentId = (String)son_Parent_Map.get(prodIdArr_t[iw]);
					if(!prodIdArr_t[iw].equals("mshow"))
					{
								if(prodIdArr_t[iw].indexOf("A") != -1){
										prodIdArr_t[iw] = prodIdArr_t[iw].split("A")[1];
									}	
									
									
									
System.out.println("A------------------------------proOptFlag     _t["+iw+"]----------------"+proOptFlag_t      );
System.out.println("A------------------------------offerIntIdArr  _t["+iw+"]----------------"+offerIntIdArr_t[iw]   );
System.out.println("A------------------------------proIntIdArr    _t["+iw+"]----------------"+proIntIdArr_t[iw]     );
System.out.println("A------------------------------prodIdArr      _t["+iw+"]----------------"+prodIdArr_t[iw]       );
System.out.println("A------------------------------type           _t["+iw+"]----------------"         );
System.out.println("A------------------------------currentTime    _t["+iw+"]----------------"+currentTime      );
System.out.println("A------------------------------prodEffectDate _t["+iw+"]----------------"+prodEffectDate_t[iw]  );
System.out.println("A------------------------------prodExpireDate _t["+iw+"]----------------"+prodExpireDate_t[iw]  );
System.out.println("A------------------------------newStatu       _t["+iw+"]----------------"+newStatu_t[iw]        );
System.out.println("A------------------------------prodExpireDate _t["+iw+"]----------------"+prodExpireDate_t[iw]  );
System.out.println("A------------------------------prodEffectDate _t["+iw+"]----------------"+prodEffectDate_t[iw]  );
System.out.println("A------------------------------isMainProduct  _t["+iw+"]----------------"+isMainProduct_t[iw]   );
System.out.println("A------------------------------parentInstId   _t["+iw+"]----------------"+parentInstId_t[iw]    );
System.out.println("A------------------------------attrFlag       _t["+iw+"]----------------"+attrFlag_t[iw]        );
			%>				
				<wtc:uparams name="product" iMaxOccurs="-1">
					<wtc:uparams name="productBaseInfo" iMaxOccurs="1">
						<wtc:uparam value="<%=proOptFlag_t%>" type="string"/>
						<wtc:uparam value="<%=offerIntIdArr_t[iw]%>" type="string"/>  <!-- ����Ʒʵ��ID-->
						<wtc:uparam value="<%=proIntIdArr_t[iw]%>" type="string"/>     <!-- ��Ʒʵ��ID-->
						<wtc:uparam value="<%=prodIdArr_t[iw]%>" type="string"/>
						<wtc:uparam value="0" type="string"/>     <!-- �ͻ�Э���ʶ-->
						<wtc:uparam value="<%=currentTime%>" type="string"/>
						<wtc:uparam value="<%=prodEffectDate_t[iw]%>" type="string"/><!--��ʼʱ��-->
						<wtc:uparam value="<%=prodExpireDate_t[iw]%>" type="string"/><!--����ʱ��-->
						<wtc:uparam value="<%=newStatu_t[iw]%>" type="string"/>
						<wtc:uparam value="<%=prodExpireDate_t[iw]%>" type="string"/><!--����ʱ��-->
						<wtc:uparam value="<%=prodEffectDate_t[iw]%>" type="string"/><!--��ʼʱ��-->
						<wtc:uparam value="<%=isMainProduct_t[iw]%>" type="string"/>
						<wtc:uparam value="<%=parentInstId_t[iw]%>" type="string"/>   <!--  �ϼ���Ʒʵ��ID-->
						<wtc:uparam value="<%=attrFlag_t[iw]%>" type="string"/>		<!--   ���ϲ�Ʒ��־-->
					</wtc:uparams>					
					<wtc:uparams name="productAttrList" iMaxOccurs="1">
						
<%		
				  	String[] proAttrSignal=proAttrArr_t[iw].split(",");//ÿ����Ʒ�ĵ���������
						int num=proAttrSignal.length;
						if(proAttrArr_t[iw].equals(""))
						{
						  num=0;
						}			  	
						String[] attrId=new String[num];
						String[] attrVal=new String[num];
						for(int k=0;k<num;k++)
						{
							String [] finalArr=proAttrSignal[k].split("~");
							attrId[k]=finalArr[0];
							attrVal[k]=finalArr[1];
							if(attrVal[k].equals("M^"))
							  attrVal[k]="";
%>							
						<wtc:uparams name="productAttr" iMaxOccurs="-1">  <!-- ��Ʒ�����б�-->
	                 <wtc:uparam value="<%=proAttrOptFlag_t%>" type="string"/>
	                 <wtc:uparam value="<%=attrId[k]%>" type="string"/>
	                 <wtc:uparam value="<%=attrVal[k]%>" type="string"/>
	                 <wtc:uparam value="<%=prodEffectDate_t[iw]%>" type="string"/>
	                 <wtc:uparam value="<%=prodExpireDate_t[iw]%>" type="string"/>                                 
						</wtc:uparams>
<%
						}
%>						
					</wtc:uparams>
					<wtc:uparams name="productGroupList" iMaxOccurs="1">   <!-- ��ƷȺ���б�-->
						<wtc:uparams name="productGroup" iMaxOccurs="-1">
							<wtc:uparam value="0" type="string"/>
						</wtc:uparams>
					</wtc:uparams>
				</wtc:uparams>
	<%         
				}
		}
%>
			</wtc:uparams>
			<wtc:uparams name="userResList" iMaxOccurs="1">     <!-- �û���Դ�б�-->
			<%
				if(isCDMA ==1){
			%>				
				<wtc:uparams name="userRes" iMaxOccurs="-1">
					<wtc:uparam value="1" type="string"/>
					<wtc:uparam value="10" type="string"/>
					<wtc:uparam value="1" type="string"/>
					<wtc:uparam value="<%=serviceNo%>" type="string"/>
				</wtc:uparams>	
			<%
				}
			%>				
			</wtc:uparams>			
			<wtc:uparams name="busiFeeFactorList" iMaxOccurs="1">  <!-- Ӫҵ�����б�-->
				<wtc:uparams name="busiFeeFactor" iMaxOccurs="-1">
					<wtc:uparam value="C" type="string"/>
					<wtc:uparam value="C1" type="string"/>
					<wtc:uparam value="1" type="string"/>
					<wtc:uparam value="1" type="string"/>
					<wtc:uparam value="1" type="string"/>
					<wtc:uparam value="<%=offerIdArr[0]%>" type="string"/>
				</wtc:uparams>
			</wtc:uparams>
		</wtc:uparams>
	</wtc:uparams>
</wtc:uparams>
</wtc:uparams>
</wtc:utype> 
<%
	String retrunCode=String.valueOf(retVal.getValue(0));      //���ص�retCodeΪLONG���ͣ�
	String returnMsg=retVal.getValue(1);
%>

<%
 String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+retrunCode+
							"&opName="+opName+
							"&workNo="+workNo+
							"&loginAccept="+sysAcceptl+
							"&pageActivePhone="+phoneNo+
							"&retMsgForCntt="+returnMsg+
							"&opBeginTime="+opBeginTime; 
%>
							
<%
System.out.println("url��"+url);
%>
<jsp:include page="<%=url%>" flush="true" />

<%	
	if(retrunCode.equals("0"))
	{
%>  
   <script language='jscript'>
      rdShowMessageDialog("��Ʒ����ɹ���",2);
		  goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
   </script>            
<%
	}else
	{
%>
  <script language='jscript'>
      rdShowMessageDialog("��Ʒ���ʧ�ܣ�",0);
      history.go(-1);
  </script>
<%
	}	
%>

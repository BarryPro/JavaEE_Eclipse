<%
  /* *********************
   * ����: ����û��˵�
   * �汾: 1.0
   * ����: 2013/03/11
   * ����: zhouby
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String phoneNo = (String)request.getParameter("phoneNo");
		String date = (String)request.getParameter("date");
		String value = (String)request.getParameter("value");
		/**
		System.out.println("zhouby opCode " + opCode);
		System.out.println("zhouby inLoginNo " + inLoginNo);
		System.out.println("zhouby password " + password);
		System.out.println("zhouby phoneNo " + phoneNo);
		*/
		System.out.println("zhouby date " + date);
%>
		
		<wtc:service name="se610" routerKey="region" routerValue="<%=regionCode%>"
			 retcode="retCode" retmsg="retMsg" outnum="43">
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=date%>"/>
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="<%=value%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
		var array = [];
<%
 		String test[][] = result;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
		/**
		 * ���������
		    1	�ֻ�����	�ַ���	15		���ʻ������ѯʱ��Ϊ��
			2	�ʵ�����	�ַ���	6		��ʽΪ��YYYYMM��
			3	��������	�ַ���	6		
			4	���Ѷ��	�ַ���			��ʽΪ��a,b,c�� 2012/11/26����

		 * ���ز�����
		  SVC_ERR_NO32	���ش���	����	�ַ���	6		
			SVC_ERR_MSG32	������ʾ��Ϣ	����	�ַ���	30		
			GPARM32_0	���ش���	����	�ַ���	6		
			GPARM32_1	�ͻ�����	����	�ַ���	60		
			GPARM32_2	Ʒ������	����	�ַ���	20		
			GPARM32_3	�������	����	�ַ���	15		
			GPARM32_4	�Ʒѿ�ʼ����	����	�ַ���	8		���ڸ�ʽΪyyyyMMdd
			GPARM32_5	�Ʒѽ�������	����	�ַ���	8		���ڸ�ʽΪyyyyMMdd
			GPARM32_6	�ʵ�����	����	�ַ���	60		���û���ʼ��ʵ���Ϣ����ô�������Ϊ��
			GPARM32_7	�ʱ�	����	�ַ���	6		���û���ʼ��ʵ���Ϣ����ô�������Ϊ��
			GPARM32_8	�ʱ��ַ	����	�ַ���	100		���û���ʼ��ʵ���Ϣ����ô�������Ϊ��
			GPARM32_9	�ʻ���Ŀ	����	�ַ���	30		�ؼ���Ϣ��
			GPARM32_10	�ʻ���Ŀ���	����	�ַ���	10		�ؼ���Ϣ��
			GPARM32_11	��Ŀ����	����	�ַ���	10		�ؼ���Ϣ��
			GPARM32_12	������Ŀ	����	�ַ���	60		���д����˸��ѣ����������˸���������Żݣ������Ż���Ŀ
			GPARM32_13	������Ŀ���	����	�ַ���	10		
			GPARM32_14	���ü���	����	�ַ���	1		1��һ��2������
			GPARM32_15	��6�����·�	����	�ַ���	6		��ʽΪyyyyMM
			GPARM32_16	��6�������ѽ��	����	�ַ���	10		
			GPARM32_17	�ײͼ��̶���	����	�ַ���	10		���·��ýṹͼ
			GPARM32_18	����ͨ�ŷ�	����	�ַ���	10		
			GPARM32_19	���ӵ绰ͨ�ŷ�	����	�ַ���	10		
			GPARM32_20	������	����	�ַ���	10		
			GPARM32_21	���ż����ŷ�	����	�ַ���	10		
			GPARM32_22	������ֵҵ��ѣ�A�ࣩ	����	�ַ���	10		
			GPARM32_23	������ֵҵ��ѣ�B�ࣩ	����	�ַ���	10		
			GPARM32_24	����ҵ���	����	�ַ���	10		
			GPARM32_25	����ҵ�����	����	�ַ���	10		
			GPARM32_26	��������	����	�ַ���	10		
			GPARM32_27	�ʻ���Ŀ	����	�ַ���	30		�˻���Ҫ��Ϣ��
			GPARM32_28	���ڽ���	����	�ַ���	10		
			GPARM32_29	��������	����	�ַ���	10		
			GPARM32_30	���ڷ���	����	�ַ���	10		
			GPARM32_31	�����˷�	����	�ַ���	10		
			GPARM32_32	���ڿ���	����	�ַ���	10		
			GPARM32_33	����֧��	����	�ַ���	10		
			GPARM32_34	����֧��	����	�ַ���	10		
			GPARM32_35	���	����	�ַ���	10		
			GPARM32_36	����ֵ	����	�ַ���	10		
			GPARM32_37	�ؼ���Ϣ��father_id	����	�ַ���	10		�����ն�ʹ��
			GPARM32_38	������	����	�ַ���	1024		ȫ��ͨ���мƻ��Ż���Ϣ
			GPARM32_39	��Ϣ��֤��ʶ	����	�ַ���	2		0 �ɹ� ��1 ʧ��
			GPARM32_40	��3�������ѽ��	����	�ַ���	10		�������ѽ��
			GPARM32_41	��3�������ѽ��	����	�ַ���	10		ǰ�ڶ��������ѽ��
			GPARM32_42	��3�������ѽ��	����	�ַ���	10		ǰ�����������ѽ��

		 */
		if ("000000".equals(retCode) && result.length > 0){
				for(int i = 0; i < result.length; i++){
%>
						var t = [];
<%
						for(int j = 0; j < result[i].length; j++){
						//System.out.println("zhouby result [" + i +"][" + j + "] = " + result[i][j]);
%>					
								t[<%=j%>] = "<%=result[i][j]%>";
<%
						}
%>
						array[<%=i%>] = t;
<%
				}
		}
		//System.out.println("zhouby retCode  " +retCode);
%>
		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		response.data.add("value", "<%=value%>");
		response.data.add("result", array);
		core.ajax.receivePacket(response);
<%!
		String getIccidFtpPas(String orderPasPropPath){
		java.util.Properties propertie = new java.util.Properties();		
		String retPas = "";
		try {
			 java.io.FileInputStream inputFile = new  java.io.FileInputStream(orderPasPropPath);
			 
			propertie.load(inputFile);
			retPas = (String) propertie.get("ftpPassword");
		    inputFile.close();      
		} catch (java.io.FileNotFoundException ex) {      
		    System.out.println("�ļ�������");      
		    ex.printStackTrace();      
		} catch (java.io.IOException ex) {      
		    System.out.println("װ���ļ�ʧ��");      
		    ex.printStackTrace();      
		}
		return retPas;
	}
%>
<%!
		String getPas(String orderPasPropPath){
		java.util.Properties propertie = new java.util.Properties();    
		
		/*String path = Thread.currentThread().getContextClassLoader().getResource("").getPath();  
		path = path.substring(1,path.length()); 
		path = path.substring(0,path.indexOf("/"));*/		
		
		String retPas = "";
		try {      
			 /*java.io.FileInputStream inputFile = new  java.io.FileInputStream("/"+path+"/applications/DefaultWebApp/npage/innet/configFtpPrintOrderPas.properties");*/
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
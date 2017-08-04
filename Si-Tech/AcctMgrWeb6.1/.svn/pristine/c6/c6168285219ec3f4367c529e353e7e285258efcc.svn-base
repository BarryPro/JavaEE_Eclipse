package com.sitech.acctmgr.atom.impl.volume;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

import com.sitech.acctmgr.net.RequestData;
import com.sitech.acctmgr.net.ResponseData;
import com.sitech.acctmgr.net.impl.AbstractServerProxy;

public class VolumeServerProxy extends AbstractServerProxy {
    private static int LENGTH = 6;


    @Override
    public void loadServerInfo() {

    }

    @Override
    public ResponseData query(RequestData arg0) {
        Socket s = new Socket();

        InputStream inStream = null;
        OutputStream outStream = null;

        byte[] wrtbuf = arg0.getRequestString().getBytes();
        try {
            s.setReuseAddress(true);
            s.setSoTimeout(timeout);
            s.connect(server.getSocketAddress(), timeout);
            inStream = s.getInputStream();
            outStream = s.getOutputStream();
            outStream.write(wrtbuf);
            outStream.flush();
            if (logger.isDebugEnabled()) {
                logger.debug("request = [" + new String(wrtbuf) + "]");
            }

            setResponseData(readResponseData(inStream));
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (outStream != null) {
                    outStream.close();
                }

                if (inStream != null) {
                    inStream.close();
                }

                if (s != null) {
                    s.close();
                }
            } catch (IOException e) {
                logger.error(e.getMessage());
            }
        }
        return respData;
    }

    @Override
    public String readResponseData(InputStream arg0) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] length = new byte[LENGTH];
        String msgLength = null;
        int totalLength = 0;
        String resppkg = null;

        try {
            for (int i = 0; i < LENGTH; i++) {
                length[i] = (byte) arg0.read();
            }
            msgLength = new String(length);
            logger.debug("msgLength = " + msgLength);
            while (true) {
                baos.write(arg0.read());
                totalLength++;
                if (totalLength >= Integer.parseInt(msgLength) - LENGTH) {
                    break;
                }
            }
            resppkg = msgLength + new String(baos.toByteArray(), "GBK");
            if (logger.isDebugEnabled()) {
                logger.debug("response string:[" + resppkg + "]");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        return resppkg;
    }

    @Override
    public void setResponseData(String arg0) {
        respData = new VolumeResponseData(arg0);
    }

}

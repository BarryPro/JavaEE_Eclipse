package com.belong.ip;

import com.maxmind.geoip.Location;
import com.maxmind.geoip.LookupService;

import java.net.URL;


/**
 * The type Ip to location.
 */
public class IpToLocation {
    /**
     * Gets ip to location.
     *
     * @param ip :221.207.241.94
     */
    public static void getIpToLocation(String ip) {
        try {
            // 得到资源目录下的资源文件
            URL url = IpToLocation.class.getClassLoader().getResource("dat/GeoLiteCity-2013-01-18.dat");
            LookupService cl = new LookupService(url.getPath(), LookupService.GEOIP_MEMORY_CACHE);
            Location l2 = cl.getLocation(ip);
            System.out.println(
                    "countryCode: " + l2.countryCode + "\n" +
                            "countryName: " + l2.countryName + "\n" +
                            "region: " + l2.region + "\n" +
                            "city: " + l2.city + "\n" +
                            "latitude: " + l2.latitude + "\n" +
                            "longitude: " + l2.longitude);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        getIpToLocation("139.162.122.59");
    }
}

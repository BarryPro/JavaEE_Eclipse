package com.sitech.acctmgr.common.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.CellUtil;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.KeyValue;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.HConnection;
import org.apache.hadoop.hbase.client.HConnectionManager;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.HTableInterface;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.util.Bytes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgr.atom.busi.invoice.ElecInvoice;

public class HbaseUtils {

	private static Logger log = LoggerFactory.getLogger(ElecInvoice.class);
	public static Configuration configuration;
	public static String family = "c1";
	public static HConnection connection;

	static {
		try {
			configuration = HBaseConfiguration.create();
			ExecutorService pool = Executors.newCachedThreadPool();
			connection = HConnectionManager.createConnection(configuration, pool);
			log.error("Hbase_connection===>" + connection);
		} catch (IOException e) {
			e.printStackTrace();
			log.error("Hbase_conn init....", e);
		}
	}

	/**
	 * @deprecated
	 */
	public static HConnection getConnection() throws Exception {
		return connection;
	}

	public static List<String> findByRowKeys(String tableName, List<String> rowkeys, int caching) throws Exception {
		List<String> list = new ArrayList<String>();
		HTableInterface table = null;
		ResultScanner rs = null;
		try {
			table = connection.getTable(tableName);

			Iterator<String> localIterator = rowkeys.iterator();
			while (localIterator.hasNext()) {
				String rowkey = (String) localIterator.next();
				Scan scan = new Scan();
				scan.setCaching(caching);
				scan.setStartRow(Bytes.toBytes(rowkey));
				scan.setStopRow(Bytes.toBytes(rowkey));
				rs = table.getScanner(scan);
				for (Result r = rs.next(); r != null; r = rs.next()) {
					Cell[] cells = r.rawCells();
					list.add(Bytes.toString(CellUtil.cloneValue(cells[0])));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

			rs.close();
			table.close();
		} finally {
			rs.close();
			table.close();
		}

		return list;
	}

	public static String findSingleByRowKey(String tableName, String rowKey) throws Exception {
		HTableInterface table = null;
		ResultScanner rs = null;
		try {
			table = connection.getTable(tableName);
			Scan scan = new Scan();
			scan.setStartRow(Bytes.toBytes(rowKey));
			scan.setStopRow(Bytes.toBytes(rowKey));
			rs = table.getScanner(scan);

			if (rs != null) {
				Result r = rs.next();
				Cell[] cells = r.rawCells();
				return Bytes.toString(CellUtil.cloneValue(cells[0]));
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			table.close();
		}
		return null;
	}

	public static Map<String, String> findMapByRowKey(String tableName, String rowKey) throws Exception {
		HTableInterface table = null;
		ResultScanner rs = null;
		try {
			table = connection.getTable(tableName);
			log.debug("table122========>" + table);
			Scan scan = new Scan();
			scan.setStartRow(Bytes.toBytes(rowKey));
			scan.setStopRow(Bytes.toBytes(rowKey));
			log.debug("scan125========>" + scan);
			rs = table.getScanner(scan);
			log.debug("rs128========>" + rs);
			if (rs != null) {
				Map<String, String> map = new HashMap<String, String>();
				Result r = rs.next();
				Cell[] cells = r.rawCells();
				for (Cell cell : cells) {
					map.put(Bytes.toString(CellUtil.cloneQualifier(cell)), Bytes.toString(CellUtil.cloneValue(cell)));
				}
				return map;
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			table.close();
		}
		return null;
	}

	public static void putRowByMap(String tableName, String rowKey, Map<String, Object> map) throws Exception {
		HTableInterface table = null;
		try {
			table = connection.getTable(tableName);
			Put put = new Put(Bytes.toBytes(rowKey));
			for (Iterator<String> localIterator = map.keySet().iterator(); localIterator.hasNext();) {
				String key = (String) localIterator.next();
				put.add(Bytes.toBytes(family), Bytes.toBytes(key), Bytes.toBytes(map.get(key).toString()));
			}
			table.put(put);
		} catch (Exception e) {
			e.printStackTrace();
			table.close();
		} finally {
			table.close();
		}
	}

	public static String getRow(String tableName, String rowKey) throws Exception {
		HTableInterface table = null;
		try {

			Get get = new Get(Bytes.toBytes(rowKey));
			log.debug("get175===========>" + get);
			System.out.println("Hbase_conn====>" + connection);
			table = connection.getTable(tableName);
			log.debug("table175===========>" + table);
			Result r = table.get(get);
			log.debug("Result177===========>" + r);
			Cell[] cells = r.rawCells();
			System.out.println("cells179===========>" + cells);

			return Bytes.toString(CellUtil.cloneValue(cells[0]));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			table.close();
		}
		return null;
	}

	public static String getValue(String tableName, String rowKey) throws Exception {
		HTableInterface table = null;
		try {

			Get get = new Get(Bytes.toBytes(rowKey));
			table = new HTable(configuration, Bytes.toBytes(tableName));// 获取表
			String value = "";
			Result result = table.get(get);
			for (KeyValue kv : result.list()) {
				log.debug("family:" + Bytes.toString(kv.getFamily()));
				log.debug("qualifier:" + Bytes.toString(kv.getQualifier()));
				log.debug("value:" + Bytes.toString(kv.getValue()));
				log.debug("Timestamp:" + kv.getTimestamp());
				log.debug("-------------------------------------------");
				value = Bytes.toString(kv.getValue());
			}

			return value;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			table.close();
		}
		return null;
	}
}

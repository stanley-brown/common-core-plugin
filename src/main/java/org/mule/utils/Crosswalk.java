package org.mule.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;

public class Crosswalk {
	private static final LinkedHashMap<String, LinkedHashMap<String, Object>> data = new LinkedHashMap<>();
	
	public static Map<String, Object> loadCSV(String csvFile, boolean skipHeader, boolean multi) {
		LinkedHashMap<String, Object> map = new LinkedHashMap<>();
		
		// we only load the data once.  This means subsequent attempts to read will be ignored.  This saves a lot of time.
		if (!data.containsKey(csvFile)) {
            InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream(csvFile);
            if (is == null) {
                throw new IllegalArgumentException("File not found: " + csvFile);
            }

	        try (CSVReader csvReader = new CSVReader(new InputStreamReader(is))) {
	            String[] line;
	            
	            // skip header.  we always expect a header for csv readability
	            if (skipHeader) {
	            	csvReader.readNext();
	            }
	            
	            while ((line = csvReader.readNext()) != null) {
	            	if (multi) {
	            		// Skip the first element
	                    List<String> result = Arrays.asList(Arrays.copyOfRange(line, 1, line.length));
	            		
	                    map.put(line[0], result);
	            	}
	            	else {
	            		map.put(line[0], line[1]);
	            	}
	            }
	        } catch (IOException e) {
	        	e.printStackTrace();
	        	return map;
	        } catch (CsvValidationException e) {
				e.printStackTrace();
				return map;
			}
	        
	        data.put(csvFile, map);
		}
		return map;
	}
	
	public static boolean contains(String alias) {
		return data.containsKey(alias);
	}
	
	public static Object set(String alias, LinkedHashMap<String, Object> obj) {
		data.put(alias, obj);
		return obj;
	}
	
	/*
	 * The set feature allows some dynamic setting of the existing loaded maps.  But the majority of data should still start with load features
	 */
	public static Object set(String alias, String key, Object value) {
		LinkedHashMap<String, Object> map = data.get(alias);
		if (map == null) {
			map = new LinkedHashMap<String, Object>();
			data.put(alias, map);
		}
		map.put(key, value);
		return value;
	}
}

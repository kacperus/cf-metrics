package org.kacperus.cf.coverage.utils;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;

public class TransformationTool {

	public static String intArray2String(int[] array){
		String toReturn = ArrayUtils.toString(array);
		return toReturn.substring(1, toReturn.length()-1);
	}
	
	public static int[] string2IntArray(String str){
		String[] numbers = StringUtils.split(str, ',');
		int[] toReturn = new int[numbers.length];
		for(int i=0; i<numbers.length; i++){
			toReturn[i] = Integer.parseInt(numbers[i]);
		}
		return toReturn;
	}
	
}

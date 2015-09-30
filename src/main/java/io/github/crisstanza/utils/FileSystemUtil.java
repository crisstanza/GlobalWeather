package io.github.crisstanza.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * @author crisstanza, 30-Sep-2015
 */
public final class FileSystemUtil {

	private FileSystemUtil() {
	}

	public static final String read(final InputStream in) {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(in));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
			return sb.toString();
		} catch (Exception exc) {
			throw ExceptionUtil.newRuntimeException(exc);
		} finally {
			Closer.close(reader);
		}
	}

}

package io.github.crisstanza.utils;

import java.io.Closeable;

/**
 * @author crisstanza, 30-Sep-2015
 */
public final class Closer {

	private Closer() {
	}

	public static final void close(Closeable closeMe) {
		try {
			if (closeMe != null) {
				closeMe.close();
			}
		} catch (Exception exc) {
			// nada a fazer!
		}
	}

}

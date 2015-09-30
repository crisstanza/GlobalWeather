package io.github.crisstanza.utils;

/**
 * @author crisstanza, 30-Sep-2015
 */
public final class ExceptionUtil {

	public static final RuntimeException newRuntimeException(final Exception exc) {
		final RuntimeException rexc = new RuntimeException(exc);
		rexc.setStackTrace(exc.getStackTrace());
		return rexc;
	}

}

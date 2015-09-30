package io.github.crisstanza.globalweather.config;

import io.github.crisstanza.utils.ExceptionUtil;

import java.net.URL;
import java.util.ResourceBundle;

/**
 * @author crisstanza, 30-Sep-2015
 */
public final class Config {

	private enum ConfigKeys {
		URL_GLOBAL_WEATHER, USER, PASS;
	}

	private static final Config instance = new Config();

	private final ResourceBundle rb = ResourceBundle.getBundle(Config.class.getSimpleName().toLowerCase());

	// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

	private Config() {
	}

	// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

	public static final Config getInstance() {
		return instance;
	}

	// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

	private String getString(final ConfigKeys key) {
		return rb.getString(key.name());
	}

	private URL getUrl(final String url) {
		try {
			return new URL(url);
		} catch (Exception exc) {
			throw ExceptionUtil.newRuntimeException(exc);
		}
	}

	// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

	public URL getUrlGlobalWeather() {
		return getUrl(getString(ConfigKeys.URL_GLOBAL_WEATHER));
	}

	public final String getUsuario() {
		return getString(ConfigKeys.USER);
	}

	public final String getSenha() {
		return getString(ConfigKeys.PASS);
	}

}

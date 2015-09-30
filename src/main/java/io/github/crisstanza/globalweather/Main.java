package io.github.crisstanza.globalweather;

import io.github.crisstanza.globalweather.client.GlobalWeatherClient;

/**
 * @author crisstanza, 30-Sep-2015
 */
public final class Main {

	private final GlobalWeatherClient client;

	private Main() {
		this.client = new GlobalWeatherClient();
	}

	public static final void main(String[] args) {
		Main main = new Main();
		main.start();
	}

	private final void start() {
		client.start();
	}

}

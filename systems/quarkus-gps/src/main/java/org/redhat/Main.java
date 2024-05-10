package org.redhat;

import io.quarkus.runtime.annotations.QuarkusMain;

import io.quarkus.runtime.Quarkus;

@QuarkusMain
public class Main {

    /* This is the main class that starts the whole application */

    /* Everything start from here */
    public static void main(String... args) {
        Quarkus.run(GpsApp.class, args);
    }
}

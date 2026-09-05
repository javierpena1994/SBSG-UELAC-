package com.sbsg.contingencias.config;

import java.io.File;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import com.zaxxer.hikari.HikariDataSource;

@Configuration
public class DatabaseConfig {

    private static final Logger log = LoggerFactory.getLogger(DatabaseConfig.class);

    @Value("${DB_URL:#{null}}")
    private String customDbUrl;

    @Value("${spring.datasource.username:sa}")
    private String dbUsername;

    @Value("${spring.datasource.password:}")
    private String dbPassword;

    @Bean
    @Primary
    @ConditionalOnProperty(name = "spring.datasource.driver-class-name", havingValue = "org.h2.Driver", matchIfMissing = true)
    public DataSource dataSource() {
        if (customDbUrl != null && !customDbUrl.trim().isEmpty()) {
            log.info("Usando URL de base de datos personalizada: {}", customDbUrl);
            HikariDataSource ds = new HikariDataSource();
            ds.setDriverClassName("org.h2.Driver");
            ds.setJdbcUrl(customDbUrl);
            ds.setUsername(dbUsername);
            ds.setPassword(dbPassword);
            return ds;
        }

        // Búsqueda inteligente del archivo .mv.db existente con todos los datos
        String[] possiblePaths = {
            "data/sbsg_contingencias_db.mv.db",
            "../data/sbsg_contingencias_db.mv.db",
            "backend/data/sbsg_contingencias_db.mv.db",
            "database/sbsg_contingencias_db_backup.mv.db",
            "../database/sbsg_contingencias_db_backup.mv.db"
        };

        File selectedDbFile = null;
        for (String path : possiblePaths) {
            File f = new File(path);
            if (f.exists() && f.isFile() && f.length() > 0) {
                selectedDbFile = f;
                log.info("Base de datos persistente H2 detectada en: {} (Tamaño: {} bytes)", f.getAbsolutePath(), f.length());
                break;
            }
        }

        String dbBasePath;
        if (selectedDbFile != null) {
            String absPath = selectedDbFile.getAbsolutePath().replace("\\", "/");
            if (absPath.endsWith(".mv.db")) {
                dbBasePath = absPath.substring(0, absPath.length() - 6);
            } else {
                dbBasePath = absPath;
            }
        } else {
            // Si no existe, asegurar carpeta data/
            File dataDir = new File("data");
            if (!dataDir.exists()) {
                dataDir.mkdirs();
            }
            dbBasePath = new File(dataDir, "sbsg_contingencias_db").getAbsolutePath().replace("\\", "/");
            log.warn("No se encontró base de datos previa. Inicializando nueva en: {}", dbBasePath);
        }

        String jdbcUrl = "jdbc:h2:file:" + dbBasePath + ";MODE=MySQL;DB_CLOSE_DELAY=-1;DATABASE_TO_UPPER=false";
        log.info("Conectando DataSource H2 a: {}", jdbcUrl);

        HikariDataSource ds = new HikariDataSource();
        ds.setDriverClassName("org.h2.Driver");
        ds.setJdbcUrl(jdbcUrl);
        ds.setUsername(dbUsername);
        ds.setPassword(dbPassword);
        ds.setMaximumPoolSize(10);
        return ds;
    }
}


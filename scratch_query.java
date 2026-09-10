import java.sql.*;

public class scratch_query {
    public static void main(String[] args) throws Exception {
        String url = "jdbc:h2:file:./data/sbsg_contingencias_db;MODE=MySQL;DATABASE_TO_UPPER=false";
        try (Connection conn = DriverManager.getConnection(url, "sa", "")) {
            System.out.println("Connected to H2!");
            // Check docente
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT id, nombre_completo FROM docentes WHERE nombre_completo LIKE '%Rosa%' OR nombre_completo LIKE '%Rivera%'")) {
                while (rs.next()) {
                    System.out.println("Docente: " + rs.getLong(1) + " -> " + rs.getString(2));
                }
            }
            // Check horarios_clases
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT hc.id, hc.dia_semana, hc.franja_horaria_id, hc.es_clase, hc.actividad, c.nombre as curso, m.nombre as materia " +
                        "FROM horarios_clases hc " +
                        "LEFT JOIN cursos c ON hc.curso_id = c.id " +
                        "LEFT JOIN materias m ON hc.materia_id = m.id " +
                        "JOIN docentes d ON hc.docente_id = d.id " +
                        "WHERE d.nombre_completo LIKE '%Rosa%' OR d.nombre_completo LIKE '%Rivera%'")) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    System.out.println("  " + rs.getString("dia_semana") + " | franja:" + rs.getLong("franja_horaria_id") + 
                                       " | esClase:" + rs.getBoolean("es_clase") + " | actividad:" + rs.getString("actividad") + 
                                       " | curso:" + rs.getString("curso") + " | materia:" + rs.getString("materia"));
                }
                System.out.println("Total slots Rosa Rivera: " + count);
            }
        }
    }
}

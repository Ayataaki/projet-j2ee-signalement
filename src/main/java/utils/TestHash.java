package utils;

public class TestHash {
    public static void main(String[] args) {
        // 1. Générer un nouveau hash pour le mot de passe "123456789"
        String password = "123456789";
        String newHash = PasswordHashUtil.hashPassword(password);
        
        System.out.println("=== NOUVEAU HASH À METTRE EN BASE ===");
        System.out.println("Mot de passe : " + password);
        System.out.println("Hash généré  : " + newHash);
        System.out.println("Longueur     : " + newHash.length());
        System.out.println();
        
        // 2. Vérifier immédiatement
        boolean isValid = PasswordHashUtil.verifyPassword(password, newHash);
        System.out.println("Vérification : " + isValid + " ✓");
        System.out.println();
        
        // 3. Test avec un mauvais mot de passe
        boolean isFalse = PasswordHashUtil.verifyPassword("wrongpassword", newHash);
        System.out.println("Vérification avec mauvais mdp : " + isFalse + " ✗");
        System.out.println();
        
        // 4. IMPORTANT : Requête SQL à exécuter
        System.out.println("=== REQUÊTE SQL À EXÉCUTER ===");
        System.out.println("UPDATE Citoyen");
        System.out.println("SET motDePasse = '" + newHash + "'");
        System.out.println("WHERE email = 'GH123457@municipal.ma';");
    }
}
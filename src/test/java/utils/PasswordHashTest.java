package utils;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class PasswordHashTest {

	@Test
	public void testHashPassword_NotNullOrEmpty() {
		String password = "TestPassword123!";
		String hashed = PasswordHashUtil.hashPassword(password);

		assertNotNull("Le mot de passe haché ne doit pas être null", hashed);
		assertFalse("Le mot de passe haché ne doit pas être vide", hashed.isEmpty());
		assertNotEquals("Le hash ne doit pas être identique au mot de passe d'origine", password, hashed);
	}

	@Test(expected = IllegalArgumentException.class)
	public void testHashPassword_EmptyPassword_ThrowsException() {
		PasswordHashUtil.hashPassword("");
	}

	@Test(expected = IllegalArgumentException.class)
	public void testHashPassword_NullPassword_ThrowsException() {
		PasswordHashUtil.hashPassword(null);
	}

	@Test
	public void testVerifyPassword_CorrectPassword_ReturnsTrue() {
		String password = "SecurePass!123";
		String hashed = PasswordHashUtil.hashPassword(password);

		assertTrue("Le mot de passe correct doit être validé", PasswordHashUtil.verifyPassword(password, hashed));
	}

	@Test
	public void testVerifyPassword_IncorrectPassword_ReturnsFalse() {
		String password = "SecurePass!123";
		String wrongPassword = "WrongPass456";
		String hashed = PasswordHashUtil.hashPassword(password);

		assertFalse("Un mot de passe incorrect ne doit pas être validé",
				PasswordHashUtil.verifyPassword(wrongPassword, hashed));
	}

	@Test
	public void testVerifyPassword_NullValues_ReturnsFalse() {
		assertFalse(PasswordHashUtil.verifyPassword(null, "someHash"));
		assertFalse(PasswordHashUtil.verifyPassword("password", null));
		assertFalse(PasswordHashUtil.verifyPassword(null, null));
	}

	@Test
	public void testHashingProducesDifferentHashesForSamePassword() {
		String password = "SamePassword123!";
		String hash1 = PasswordHashUtil.hashPassword(password);
		String hash2 = PasswordHashUtil.hashPassword(password);

		assertNotEquals("Deux hachages du même mot de passe doivent être différents (car salt aléatoire)", hash1,
				hash2);
	}

}

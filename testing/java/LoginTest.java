package testing;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class LoginTest {

    public static void main(String[] args) {

        WebDriver driver = new ChromeDriver();

        try {

            driver.get(
                    "http://localhost:8080/SmartCampusNavigation/login.jsp");

            driver.findElement(
                    By.name("username")).sendKeys("Dharshini");

            driver.findElement(
                    By.cssSelector("button[type='submit']")).click();

            String title = driver.getTitle();

            if (title.equals("Welcome")) {

                System.out.println(
                        "LOGIN TEST PASSED");

            } else {

                System.out.println(
                        "LOGIN TEST FAILED");
            }

        } finally {

            driver.quit();
        }
    }
}
public class Admin extends Person{
    private String id = "Admin";
    private String pw = "Admin1234";

    public Admin(String name, String phone){
        super(name, phone);
    }

    public boolean isCorrectAccount(String inputId, String inputPw){
        return id.equals(inputId) && pw.equals(inputPw);
    }

    public String getId(){
        return this.id;
    }

}

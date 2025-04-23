public class User extends Person{
    protected String id;
    public User(String name, String phone, String id){
        super(name, phone);
        this.id = id;
    }

    public String getId(){
        return this.id;
    }
}

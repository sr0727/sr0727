import java.util.*;

public class GradeManager {
    private static Admin admin;
    private final Map<String, Student> studentMap = new HashMap<>();
    private final List<Student> studentList = new ArrayList<>();

    public void run(){
        while (true){
            Scanner sc = new Scanner(System.in);
            System.out.println("<< 성적 처리 >>");
            System.out.println("1. 관리자 로그인");
            System.out.println("2. 종료");
            String select = sc.nextLine();

            if(select.equals("1")){
                if(adminLogin()){
                    gradeMenu();
                }
            } else if (select.equals("2")) {
                System.out.println("프로그램을 종료합니다.");
                break;
            }
        }
    }

    public boolean adminLogin(){
        Scanner sc = new Scanner(System.in);
        System.out.print("Name : " );
        String name = sc.nextLine();
        System.out.print("Phone : " );
        String phone = sc.nextLine();
        System.out.print("ID : " );
        String id = sc.nextLine();
        System.out.print("PW : " );
        String pw = sc.nextLine();

        admin = new Admin(name, phone);
        if(admin.isCorrectAccount(id, pw)){
            System.out.println(name + "관리자님 반갑습니다.");
            return true;
        }else {
            System.out.println("관리자 계쩡이 틀렸습니다.");
            return false;
        }
    }

    public void gradeMenu(){
        while (true){
            Scanner sc = new Scanner(System.in);
            System.out.println("<< 성적처리 >>");
            System.out.println("1. 성적 입력");
            System.out.println("2. 성적 검색");
            System.out.println("3. 전체 성적 출력");
            System.out.println("4. 로그아웃");
            String select = sc.nextLine();

            switch (select){
                case "1":
                    this.inputGrades();
                    break;
                case "2" :
                    this.searchGrade();
                    break;
                case "3":
                    this.printAllGrades();
                    break;
                case "4":
                    return;
            }
        }
    }
    public void inputGrades(){
        while (true){
            Scanner sc = new Scanner(System.in);
            System.out.print("ID : ");
            String id = sc.nextLine();
            System.out.print("Name : ");
            String name = sc.nextLine();
            System.out.print("Phone : ");
            String phone = sc.nextLine();
            System.out.print("국어 : ");
            int kor = Integer.parseInt(sc.nextLine());
            System.out.print("영어 : ");
            int eng = Integer.parseInt(sc.nextLine());
            System.out.print("수학 : ");
            int math = Integer.parseInt(sc.nextLine());

            Student student = new Student(id, name, phone, kor, eng, math);
            studentMap.put(id, student);
            studentList.add(student);
            System.out.print("계속 입력하시겠습니까??  Y | N");
            String cont = sc.nextLine();
            if (!cont.toUpperCase().equals("Y")){
                System.out.println("모든 학생의 입력이 끝났습니다.");
                break;
            }
        }
    }

    public void searchGrade(){

    }

    public void printAllGrades(){

    }


}

public class Student extends User{
    private int kor;//국어
    private int eng;//영어
    private int math;//수학

    public Student(String id, String name, String phone, int kor, int eng, int math){
        super(name, phone, id);
        this.kor = kor;
        this.eng = eng;
        this.math = math;
    }
    public void printGrade(){
        int total = kor + eng + math;//총점
        double avg = total / 3.0;//평균
        System.out.println("ID" + getId());
        System.out.println("Name" + getName());
        System.out.println("국어" + kor);
        System.out.println("영어" + eng);
        System.out.println("수학" + math);
        System.out.println("총점" + total);
        System.out.println("평균" + avg);
    }
}

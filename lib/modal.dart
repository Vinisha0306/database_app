class Employee {
  int id;
  String name;
  double salary;
  String dept;
  String city;
  String gender;
  String exp;
  String contact;
  String email;

  Employee(this.id, this.name, this.salary, this.dept, this.city, this.gender,
      this.exp, this.contact, this.email);

  factory Employee.fromSQL({required Map data}) => Employee(
        data['id'],
        data['name'],
        data['salary'],
        data['dept'],
        data['city'],
        data['gender'],
        data['exp'],
        data['contact'],
        data['email'],
      );

  Map<String, dynamic> get getEmployee => {
        "id": id,
        "name": name,
        "salary": salary,
        "dept": dept,
        "city": city,
        "gender": gender,
        "exp": exp,
        "contact": contact,
        "email": email,
      };
}

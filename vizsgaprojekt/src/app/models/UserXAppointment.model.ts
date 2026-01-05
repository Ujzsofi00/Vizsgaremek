export interface UserXAppointment {
    userXAppointmentId: number;
    userId: number;
    appointment: number;
}

//export class név {
//   konstruktor               --> Inkább így kéne!
//}{}

//Dynamic data show(adat a ts fájlból, amit szeretnék megjeleníteni az oldalon) --> Use: ""
//For example: <img [src]="'assets/users/' + selectedUser.avatar" [alt]="selectedUser.name" />
//BUT get functionName() is better IN THE TS FILE!
// Like this: return 'assets/users/' + this.selectedUser.avatar
//THIS is very important. We have to use it if we are using a property inside of a class.
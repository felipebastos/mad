import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { User } from './users.models';
import { UsersService } from './users.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  users: Observable<User[]> = new Observable<User[]>();

  constructor(private users_service: UsersService) { }

  ngOnInit(): void {
    this.users = this.users_service.getUsers();
  }

}

import mongoose from "mongoose";

const Schema = mongoose.Schema;

interface User {
  email: string;
  password: string;
}

let userSchema = new Schema<User>(
  {
    email: {
      type: String,
      required: true,
      unique: true,
      match: [
        /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
        "Please enter a valid email address",
      ],
    },
    password: {
      type: String,
      required: true,
    },
  },
  { collection: "USERS" }
);

const UserModel = mongoose.model<User>("User", userSchema);
export { UserModel };

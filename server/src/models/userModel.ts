import mongoose from "mongoose";

const Schema = mongoose.Schema;

interface User {
  email: string;
  password: string;
  name: string;
  urls: [];
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
    name: {
      type: String,
    },
    urls: [
      {
        type: Schema.Types.ObjectId,
        ref: "URL",
      },
    ],
  },
  { collection: "USERS" }
);

const UserModel = mongoose.model<User>("User", userSchema);
export { UserModel };

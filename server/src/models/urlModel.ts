import mongoose, { Collection } from "mongoose";

const Schema = mongoose.Schema;

interface URL {
  longUrl: string;
  shortUrl: string;
  clicks: number;
}

let urlSchema = new Schema<URL>(
  {
    longUrl: {
      type: String,
      required: true,
    },
    shortUrl: {
      type: String,
      required: true,
    },
    clicks: {
      type: Number,
      default: 0,
    },
  },
  { collection: "URLS" }
);

const URLModel = mongoose.model<URL>("URL", urlSchema);

export { URLModel };

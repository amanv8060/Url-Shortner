/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/
const env = {
  PORT: process.env.PORT||"",
  SECRET_KEY: process.env.SECRET_KEY||"",
  DB_URL: process.env.DB_URL||"",
  APP:"https://url-shortner-lemon.vercel.app/"
};

export default env;

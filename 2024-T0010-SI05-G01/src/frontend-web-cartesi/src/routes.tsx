// routes.tsx
import { Suspense, lazy } from "react";
import { Routes, Route } from "react-router-dom";
import App from "./App";
import App2 from "./App2";

const routes = [
  {
    path: "/",
    element: <App />,
  },
  {
    path: "/app2",
    element: <App2 />,
  },
];

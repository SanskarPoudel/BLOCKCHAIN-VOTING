import { Link } from "react-router-dom";
import "../scss/Home.scss";
const Home = () => {
  return (
    <>
    
      <div className="container py-4">
        <header className="pb-3 mb-4 border-bottom">
          <Link
            to="/profile"
            className="text-light text-center fw-bold text-decoration-none fs-3"
          >
            VOTING APP
          </Link>
        </header>
        <div className="image">
        <div className=" p-5 mb-4  rounded-3">
          <div className="container-fluid py-5">
            <h1 className="display-5 fw-bold">Voting Using Blockchain</h1>
            <p className="col-md-8 fs-4 py-3">
              This is the prototype and concept of decentralized Voting system
              which is made by using ethereum Blockchain environment and
              ReactJS. The acoount which is used to deploy will automatically
              become admin and other users can register using the register
              button. And the voting can be done accordingly.
            </p>

            <Link className="btn btn-primary text-light btn-lg" to="/register">
              Register / Admin Login
            </Link>
          </div>
        </div>

        </div>
        
        <footer className="pt-3 fw-bold text-light mt-4  border-top">
          Project by :- Sanskar Paudel, Pradip Subedi, Bishal Sherchan & Rabindra Adhikari
        </footer>
      </div>
    </>
  );
};

export default Home;

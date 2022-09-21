import { connect } from "react-redux";
import { Navigate, Outlet } from "react-router-dom";

const RegisterProvider = ({ user }) => {
    if (user) {
        return <Navigate to="/profile" />;
    } else {
        return <Outlet />;
    }
};
const mapStateToProps = (state) => {
    return { user: state.userReducer };
};
export default connect(mapStateToProps)(RegisterProvider);

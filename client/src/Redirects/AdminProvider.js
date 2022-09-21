import { connect } from "react-redux";
import { Navigate, Outlet } from "react-router-dom";

const RegisterProvider = ({ user, access = ["admin"] }) => {
    if (user && access.includes(user.role)) {
        return <Outlet />;
    } else {
        return <Navigate to="/" />;
    }
};
const mapStateToProps = (state) => {
    return { user: state.userReducer };
};
export default connect(mapStateToProps)(RegisterProvider);

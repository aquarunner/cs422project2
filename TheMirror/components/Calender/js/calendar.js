var months = new Array("January", "February", "March", "April", "May", "June", "July",
                   "August", "September", "October", "November", "December")

function getMonth() {
    return months[date.getMonth()]
}

function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate()
}

function appendDate(day, month, year, currentDay, currentMonth)
{
    var data = { 'day' : day, 'month' : month, 'year' : year, 'currentDay' : currentDay, 'currentMonth' : currentMonth}
    monthModel.append(data)
}

function populateModel()
{
    monthModel.clear()

    var firstDayMonth = new Date(date.getFullYear(), date.getMonth(), 1)
    if (firstDayMonth.getDay() != weekModel.get(0).value) {
        //XXX: for january the code is buggy
        var lastMonthDays = daysInMonth(date.getFullYear(), date.getMonth() - 1)
        for (var i = lastMonthDays - weekModel.get(firstDayMonth.getDay()).value + 1; i <= lastMonthDays; i++) {
            appendDate(i, date.getMonth() - 1, date.getFullYear(), false, false)
        }
    }

    var currentDaysInMonth = daysInMonth(date.getFullYear(), date.getMonth())
    var currentDay = new Date()
    var isCurrentDay = false
    for (var i = 1; i < currentDaysInMonth; i++) {
        if (currentDay.getDate() == i)
            isCurrentDay = true
        else
            isCurrentDay = false
        appendDate(i, date.getMonth(), date.getFullYear(), isCurrentDay, true)
    }

    if (monthModel.count < _maximumDaysInCalendar) {
        var monthModelCount = monthModel.count
        for (var i = 1; i <= _maximumDaysInCalendar - monthModelCount; i++) {
            appendDate(i, date.getMonth() + 1, date.getFullYear(), false, false)
        }
    }
}

function goToMonthYear(month, year) {
    date = new Date(year, month, 1)
    populateModel();
}

    //XXX: remove the magic numbers
function previousMonth() {
    if (date.getMonth() == 0) {
        date = new Date(date.getFullYear() - 1, 11, 1)
    } else {
        date = new Date(date.getFullYear(), date.getMonth() - 1, 1)
    }
    populateModel()
}

function nextMonth() {
    if (date.getMonth() == 11) {
        date = new Date(date.getFullYear() + 1, 0, 1)
    } else {
        date = new Date(date.getFullYear(), date.getMonth() + 1, 1)
    }
    populateModel()
}
